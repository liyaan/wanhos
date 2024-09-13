import { preferenceUtil,Constants } from '@ohos/httpUtils'

import router from '@ohos.router'
import { LOGIN } from './RouterUtils'
import { MIAN_ROUTER } from '@ohos/project'
import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common/src/main/ets/components/mainpage/log/Log'

export class Utils{
  static getMainLayout(){

    preferenceUtil.get(Constants.USERNAME).then((val)=>{
      Log.info("testTag USERNAME val  = "+JSON.stringify(val))
      if (val.toString()!==null){
        preferenceUtil.get(Constants.PASSWORD).then((val)=>{
          if(val.toString()!==null){
            router.replaceUrl({url:MIAN_ROUTER})
          }else{
            router.replaceUrl({url:LOGIN})
          }
        }).catch((err)=>{
          // router.replaceUrl({url:LOGIN})
          Log.info("testTag PASSWORD error = "+JSON.stringify(err))
        })
      }else{
        router.replaceUrl({url:LOGIN})
      }
    }).catch((err)=>{
      router.replaceUrl({url:LOGIN}).then((value)=>{
        Log.info("testTag  LOGIN error = "+JSON.stringify(value))
      }).catch((err)=>{
        Log.info("testTag  LOGIN error = "+JSON.stringify(err))
      })
       Log.info("testTag  USERNAME error = "+JSON.stringify(err))
      // router.replaceUrl({url:LOGIN})

    })
  }
}