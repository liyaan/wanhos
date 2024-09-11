import { FunctionParam, GetMethod, GetUrlValueMethod, Param } from '@ohos/httpUtils'
import { BASE_URL } from '../utils/Consts';
export class Api{
  @GetMethod(BASE_URL+"tree/json")
  getTreeJson<T>():Promise<T>{ return }

  @GetUrlValueMethod(BASE_URL+"article/list/page/json")
  listJson<T>(@FunctionParam("page") page:number,@Param("cid") cid:number):Promise<T>{ return }
}
export const api = new Api();