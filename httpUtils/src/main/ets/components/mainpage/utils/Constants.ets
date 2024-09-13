import dataPreferences from '@ohos.data.preferences';
import HashMap from '@ohos.util.HashMap';
export  class Constants {
  static readonly PREFERENCE_NAME: string = 'my_preference'
  static readonly USERNAME:string = "username"
  static readonly PASSWORD:string = "password"
  static M_CONTEXT:Context = null


  static readonly PREFERENCES_NAME = 'wanHos'
  static readonly KEY_PREFERENCES = "preferences"

  static readonly OBJECT_MAP = new HashMap<string, Object>();

}

// export const enum PreferenceKey {
//   USER_INFO = 'userInfo',
// }