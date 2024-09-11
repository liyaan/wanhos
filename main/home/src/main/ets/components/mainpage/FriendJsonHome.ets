import { TitlePage } from '@ohos/libWidght'
import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { FriendJson } from './entity/FriendJson'

@CustomDialog
@Component
export struct FriendJsonHome {
  @State friendJson: FriendJson[] = []
  cancel: () => void = ()=>{
    console.info('Callback when the second button is clicked')
  }
  confirm: () => void = () => {
    console.info('Callback when the second button is clicked')
  }
  controller: CustomDialogController = new CustomDialogController({
    builder: FriendJsonHome({
      cancel: this.cancel,
      confirm: this.confirm,
    }),
    autoCancel: true,
    customStyle: true,

  })
  aboutToAppear() {
    this.getFriendJson()
  }

  private getFriendJson() {
    api.getFriendJson<BaseEntity<Array<FriendJson>>>().then((result) => {
      if (this.friendJson.length > 0) {
        this.friendJson = []
      }
      this.friendJson.push(...result.data)
    })
  }
  _back(){
    this.cancel()
  }
  build() {
    Column(){
      TitlePage({title:"常用网站",back:this.cancel})
      Grid() {
        ForEach(this.friendJson, (item, index) => {
          GridItem() {
            Column() {
              Image("https://qna.smzdm.com/202409/08/66dd399098a88773.jpg_e680.jpg")
                .width('100%').height(100).objectFit(ImageFit.Fill).borderRadius(8)
              Text(item.name)
                .fontSize(16)
                .align(Alignment.Bottom)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }.height(120).width('100%')
          }
        }, (item) => JSON.stringify(item))
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('98%')
      .layoutWeight(1)
    }.width('100%')
    .height('100%').backgroundColor('#ffffff')
  }
}