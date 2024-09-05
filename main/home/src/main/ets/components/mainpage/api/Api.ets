import {FunctionParam,GetUrlValueMethod} from '@ohos/httpUtils'
export class Api{
  @GetUrlValueMethod("https://www.wanandroid.com/article/list/page/json")
  listJson<T>(@FunctionParam("page") page:number):Promise<T>{ return }
}
export const api = new Api();