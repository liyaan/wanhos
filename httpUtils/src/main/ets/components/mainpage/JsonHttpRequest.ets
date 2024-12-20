import { IHttpListener } from './IHttpListener';
import { IHttpRequest } from './IHttpRequest';
import http from '@ohos.net.http';
import url from '@ohos.url';
import { RequestMethod, RequestOptions } from './RequestOptions';
import {Log} from '@ohos/common'
import { TAG } from './Consts';
let httpRequest = http.createHttp();

export class JsonHttpRequest implements IHttpRequest {

  private url: string = '';

  private iHttpListener: IHttpListener = null;
  // private httpRequest: http.HttpRequest = null;


  setListener(iHttpListener: IHttpListener): JsonHttpRequest {
    this.iHttpListener = iHttpListener;
    return this
  }

   execute<T>(requestOption: RequestOptions): Promise<T> {
    // let httpRequest = http.createHttp();
     console.log("testTag ,requestOption "+requestOption.url);
    return new Promise<T>((resolve, reject) => {
      this.sendRequest(requestOption)
        .then((response) => {
          if (typeof response.result !== 'string') {
            reject(new Error(TAG+'testTag ,Invalid data type'));
            Log.log("testTag ,Invalid data type")
          } else {
            let bean: T = JSON.parse(response.result);
            Log.log(TAG+"testTag ,"+JSON.stringify(response.result))
            if (bean) {
              console.info(TAG+'testTag ,code:' + JSON.stringify(response.responseCode));
              if (this.iHttpListener) {
                if(response.header){
                  this.iHttpListener.onGetHeaders(JSON.stringify(response.header));
                  console.info(TAG+'testTag ,header:' + JSON.stringify(response.header));
                }
                if (response.cookies) {
                  this.iHttpListener.onGetCookies(JSON.stringify(response.cookies));
                  console.info(TAG+'testTag ,cookies:' + JSON.stringify(response.cookies)); // 8+
                }
                // this.iHttpListener.onGetHeaders(JSON.stringify(response.header));
                // this.iHttpListener.onGetCookies(JSON.stringify(response.cookies));
                // // data.header为HTTP响应头，可根据业务需要进行解析
                // console.info(TAG+'testTag ,header:' + JSON.stringify(response.header));
                // console.info(TAG+'testTag ,cookies:' + JSON.stringify(response.cookies)); // 8+
                // 执行结果进行回调
                // this.iHttpListener.onSuccess(data.result.toString());
              }
              resolve(bean);
              Log.log(TAG+"testTag ,Invalid data bean")
            } else {
              reject(new Error(TAG+'testTag ,Invalid data type,JSON to T failed'));
              Log.log(TAG+"testTag ,Invalid data type,JSON to T failed")
            }
          }
        }).catch((error) => {
        Log.log(TAG+"testTag ,Failed "+error)
        reject(error);
      });
    });
  }

  private sendRequest(requestOption: RequestOptions): Promise<http.HttpResponse> {
    let httpRequest = http.createHttp();

    let resolveFunction, rejectFunction;

    const resultPromise = new Promise<http.HttpResponse>((resolve, reject) => {
      resolveFunction = resolve;
      rejectFunction = reject;
    });
    if (this.url == null) {
      return Promise.reject(new Error(TAG+'testTag ,url格式不合法.'));
    }
    let promise = httpRequest.request(
      this.url,
      {
        method: requestOption.method,
        header: requestOption.header,
        extraData: requestOption.extraData,
        expectDataType: http.HttpDataType.STRING
      }
    );
    promise.then((response) => {
      // console.info(TAG+'testTag Result----:' + JSON.stringify(response.result));
      // console.info(TAG+'testTag code----:' + response.responseCode);
      // console.info(TAG+'testTag header----:' + JSON.stringify(response.header));
      if (http.ResponseCode.OK !== response.responseCode) {
        throw new Error(TAG+'testTag http responseCode !=200');
      }
      resolveFunction(response);
    }).catch((err) => {
      rejectFunction(err);
    }).finally(() => {
      // 当该请求使用完毕时，调用destroy方法主动销毁。
      httpRequest.destroy();
    })
    return resultPromise;
  }


  resultJson(err, data) {
    if (!err) {
      // data.result为HTTP响应内容，可根据业务需要进行解析
      console.info(TAG+'testTag ,Result:' + JSON.stringify(data.result));
      console.info(TAG+'testTag ,code:' + JSON.stringify(data.responseCode));

      if (this.iHttpListener) {
        // data.header为HTTP响应头，可根据业务需要进行解析
        if(data.header){
          this.iHttpListener.onGetHeaders(JSON.stringify(data.header));
          console.info(TAG+'testTag ,header:' + JSON.stringify(data.header));
        }
        if (data.cookies) {
          this.iHttpListener.onGetCookies(JSON.stringify(data.cookies));
          console.info(TAG+'testTag ,cookies:' + JSON.stringify(data.cookies)); // 8+
        }
        // 执行结果进行回调
        // this.iHttpListener.onSuccess(data.result.toString());
      }
      // 当该请求使用完毕时，调用destroy方法主动销毁
      httpRequest.destroy();
    } else {
      console.info(TAG+'testTag error:' + JSON.stringify(err));
      // this.iHttpListener.onFailure(JSON.stringify(err));
    }
  }

  setUrl(url: string): JsonHttpRequest {
    this.url = url;
    return this;
  }

}
export const httpCore = new JsonHttpRequest();