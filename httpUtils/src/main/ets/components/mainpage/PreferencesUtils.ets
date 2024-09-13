import dataPreferences from '@ohos.data.preferences';
import {  Log } from '@ohos/common';


import hilog from '@ohos.hilog';
import { Constants } from './utils/Constants';
import { GlobalContext } from './utils/GlobalContext';


const TAG = "PreferencesUtils testTag"
// 默认文件名，可以在构造函数进行修改

type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean>;

export class PreferencesUtils {
  // preferences的文件名
  private  preferencesName: string = Constants.PREFERENCES_NAME
  // 用于获取preferences实例的key值，保存到单例中
  private keyPreferences: string = Constants.KEY_PREFERENCES
  pref: dataPreferences.Preferences

  constructor(name: string = Constants.PREFERENCES_NAME, keyP: string = Constants.KEY_PREFERENCES) {
    this.preferencesName = name
    this.keyPreferences = keyP
  }

  async createPreferences(context:Context) {
    Constants.M_CONTEXT = context
    dataPreferences.getPreferences(globalThis.context, this.preferencesName).then((result)=>{
      if (result) {
        // GlobalContext.getContext().setObject(this.keyPreferences, result)
        globalThis.dataPreferences = result
        hilog.info(0x0000, 'testTag', '%{public}s', 'createPreferences re is not null'+JSON.stringify(result));
      }else{
        hilog.info(0x0000, 'testTag', 'createPreferences %{public}s', 're is  null');
      }
    }).catch((err)=>{
      hilog.info(0x0000, 'testTag', 'createPreferences catch %{public}s', JSON.stringify(err));
    })

  }

   getPreferences(): dataPreferences.Preferences {
     // let prdf = GlobalContext.getContext().getObject(this.keyPreferences) as dataPreferences.Preferences
     // if (prdf) {
     //   return prdf
     // }else{
     //   GlobalContext.getContext().setObject(this.keyPreferences, globalThis.dataPreferences)
     // }
     return globalThis.dataPreferences
  }

  async get(key: string, def?: ValueType):Promise<ValueType>{
     return this.getPreferences().get(key, def)
  }

  async getAll(){
    let  preferences =  this.getPreferences()
    return preferences.getAll()
  }

  async put(key: string, value: ValueType) {
    Log.log(TAG+" "+key)
    if (!this.getPreferences()){
      Log.log(TAG+" bbbbbbbbbbbbbbbbb "+value)
    }else{
      Log.log(TAG+" bbbbbbbbbbbbbbbbb "+JSON.stringify(this.getPreferences()))
    }

    await this.getPreferences().put(key, value).then(()=>{
      Log.log(TAG+"  await this.getPreferences()  "+value)
    }).catch((error)=>{
      Log.log(TAG+" put error "+JSON.stringify(error))
    })
    await this.getPreferences().flush().then(()=>{
      Log.log(TAG+" flush "+value)
    }).catch((error)=>{
      Log.log(TAG+" flush  catch"+JSON.stringify(error))
    })

  }



  // async delete(key: string): Promise<void> {
  //   return (await this.getPreferences()).delete(key).finally(async () => {
  //     (await this.getPreferences()).flush()
  //   })
  // }
  //
  // async clear(): Promise<void> {
  //   return (await this.getPreferences()).clear().finally(async () => {
  //     (await this.getPreferences()).flush()
  //   })
  // }

}
// export const preferencesUtils = new PreferencesUtils();
//export default new PreferencesUtils()