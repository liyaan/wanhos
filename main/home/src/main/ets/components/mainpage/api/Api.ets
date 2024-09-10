import {FunctionParam,GetUrlValueMethod,GetMethod} from '@ohos/httpUtils'
import { BASE_URL } from '../utils/Consts';
export class Api{
  @GetUrlValueMethod(BASE_URL+"article/list/page/json")
  listJson<T>(@FunctionParam("page") page:number):Promise<T>{ return }

  @GetMethod(BASE_URL+"banner/json")
  getBanner<T>():Promise<T>{ return }

  @GetMethod(BASE_URL+"friend/json")
  getFriendJson<T>():Promise<T>{ return }

  @GetMethod(BASE_URL+"hotkey/json")
  getHotkeyJson<T>():Promise<T>{ return }
}
export const api = new Api();