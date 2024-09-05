
import { httpCore } from './JsonHttpRequest';
import { RequestMethod, RequestOptions } from './RequestOptions';
import hilog from '@ohos.hilog';
import HashMap from '@ohos.util.HashMap';
import { TAG } from './Consts';
import { MapUtils ,Log} from '@ohos/common';
import { IHttpListener } from './IHttpListener';
import { AbsHttpRequest } from './AbsHttpRequest';


type headerFuc = (json: string) => void
type cookieFuc = (json: string) => void

export class HttpManager {

  private static mInstance: HttpManager;
  private headers:HashMap<string,any> ;
  private mUrl:string ;
  // 防止实例化
  private constructor() {
  }

  static getInstance(): HttpManager {
    if (!HttpManager.mInstance) {
      HttpManager.mInstance = new HttpManager();
    }
    return HttpManager.mInstance;
  }

  setUrl(url:string):HttpManager{
    this.mUrl = url;
    console.log("testTag url = "+url);
    return this
  }
  setHeader(map:HashMap<string,any>):HttpManager{
    this.headers = map;
    return this
  }
  post<T>(url:string,data: string | Object | ArrayBuffer,header?:headerFuc,cookie?:cookieFuc):Promise<T> {
    hilog.info(0x0000, 'testTag', 'post url=%{public}s map=%{public}s',url,JSON.stringify(data));
    if (this.headers==null) {
      this.headers = new HashMap();
    }
    this.headers.set('Content-Type','application/json');
    return this.request<T>(
      {
        method: RequestMethod.POST,
        header: MapUtils.map2Object(this.headers),
        url: url,
        extraData: JSON.stringify(data),
        connectTimeout:6000,
        readTimeout: 6000
      },new AbsHttpRequest(header,cookie)
    );
  }
  postFrom<T>(url:string,
              data: string | Object | ArrayBuffer,
              header?:headerFuc,cookie?:cookieFuc
  ):Promise<T> {
    if (this.headers==null) {
      this.headers = new HashMap()
    }
    this.headers.set('Content-Type','application/x-www-form-urlencoded');
    Log.log(TAG+'testTag '+MapUtils.map2Json(this.headers))
    let objString =  MapUtils.map2Object(this.headers);
    return this.request<T>(
      {
        method: RequestMethod.POST,
        header: objString,
        url: url,
        extraData: data,
        connectTimeout:6000,
        readTimeout: 6000
      },
      new AbsHttpRequest(header,cookie)
    );
  }
  get<T>(url:string,header?:headerFuc,cookie?:cookieFuc):Promise<T> {

    if (this.headers==null) {
      this.headers = new HashMap();
    }
    this.headers.set('Content-Type','application/json');
    return this.request<T>(
      {
        method: RequestMethod.GET,
        header: MapUtils.map2Object(this.headers),
        url: url,
        connectTimeout:6000,
        readTimeout: 6000
      },new AbsHttpRequest(header,cookie)
    );
  }

  request<T>(option: RequestOptions,iHttp?:IHttpListener): Promise<T> {
    console.log(option.url)
    hilog.info(0x0000, TAG+'testTag', 'request url=%{public}s extraData=%{public}s method=%{public}s',
      option.url,JSON.stringify(option.extraData),option.method.toString());
    return httpCore.setUrl(option.url).setListener(iHttp).execute(option);
  }
}