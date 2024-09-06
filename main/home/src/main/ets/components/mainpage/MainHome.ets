import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common'

import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { ListJsonData, ListJsonEntity } from './entity/ListJsonEntity'
import { TAG } from './utils/Consts'
import { PullToRefresh } from '@ohos/libWidght/oh_modules/@ohos/pulltorefresh'
import ArrayList from '@ohos.util.ArrayList'

@Component
export struct MainHome {
  @State message: string = '首页'
  @State listData: ListJsonData[] = []

  aboutToAppear() {
    api.listJson<BaseEntity<ListJsonEntity>>(0).then((result) => {
      Log.log(TAG + "  " + result.data.datas[0].title)
      this.listData = result.data.datas
    })
  }

  build() {
    Row() {
      Column() {
        List({ space: 5 }) {
          ForEach(this.listData, (item:ListJsonData, index) => {
            ListItem() {
              Text(`${item.title}`)
                .width('100%')
                .height(100)
                .fontSize(20)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0x007DFF)
            }
          },item => item)
        }
      }
      .width('100%')
    }.width('100%')
    .height('100%').backgroundColor('#FFFFFF')
  }
}
