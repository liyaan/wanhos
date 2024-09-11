import {GetMethod} from '@ohos/httpUtils'
import { BASE_URL } from '../utils/Consts';
export class Api{
  @GetMethod(BASE_URL+"navi/json")
  getNaviJson<T>():Promise<T>{ return }
}
export const api = new Api();