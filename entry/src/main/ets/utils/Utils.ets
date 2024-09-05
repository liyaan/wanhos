import PreferencesUtils from '@ohos/httpUtils'
import { PASSWORD, USERNAME } from './Consts'
import router from '@ohos.router'
import { LOGIN, MAIN } from './RouterUtils'
import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common/src/main/ets/components/mainpage/log/Log'
export class Utils{
  static getMainLayout(){
    PreferencesUtils.get(USERNAME).then((val)=>{
      if (val!=null){
        PreferencesUtils.get(PASSWORD).then((val)=>{
          if(val!=null){
            router.replaceUrl({url:MAIN})
          }else{
            router.replaceUrl({url:LOGIN})
          }
        }).catch((err)=>{
          router.replaceUrl({url:LOGIN})
          Log.info("testTag error = "+JSON.stringify(err))
        })
      }else{
        router.replaceUrl({url:LOGIN})
      }
    }).catch((err)=>{
      router.replaceUrl({url:LOGIN})
      Log.info("testTag error = "+JSON.stringify(err))
    })
  }
}