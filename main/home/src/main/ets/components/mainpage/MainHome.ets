import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common'
import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { ListJsonEntity } from './entity/ListJsonEntity'
import { TAG } from './utils/Consts'
@Component
export struct MainHome {
  @State message: string = '首页'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            api.listJson<BaseEntity<ListJsonEntity>>(0).then((result)=>{
              Log.log(TAG+"  "+result.data.datas[0].title)
            })
          })
      }
      .width('100%')
    }.width('100%')
    .height('100%').backgroundColor('#FFFFFF')
  }
}
