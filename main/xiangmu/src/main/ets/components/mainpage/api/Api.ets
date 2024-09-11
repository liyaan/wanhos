import { FunctionParam, GetMethod, GetUrlValueMethod, Param } from '@ohos/httpUtils'
import { BASE_URL } from '../utils/Consts';
export class Api{
  @GetMethod(BASE_URL+"project/tree/json")
  getProjectJson<T>():Promise<T>{ return }

  @GetUrlValueMethod(BASE_URL+"project/list/page/json")
  getProjectList<T>(@FunctionParam("page") page:number,@Param("cid") cid:number):Promise<T>{ return }
}
export const api = new Api();