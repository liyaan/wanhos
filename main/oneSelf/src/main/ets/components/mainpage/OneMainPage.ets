import { preferenceUtil, Constants } from '@ohos/httpUtils'
import router from '@ohos.router'
import { SCROLLDHJB,LISTHEADER } from "@ohos/onelibrary"

@Component
export struct OneMainPage {
  @State userName: string = ""
  @State passWord: string = ""
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    preferenceUtil.get(Constants.USERNAME).then((result) => {
      this.userName = result.toString()
    })
  }

  build() {
    Column() {
      Row() {
        Image('https://k.sinaimg.cn/n/sinakd20117/0/w800h800/20240127/889b-4c8a7876ebe98e4d619cdaf43fceea7c.jpg/w700d1q75cms.jpg')
          .width(50)
          .height(50)
          .borderRadius(25)
          .borderWidth(1)
          .borderColor('#ccc')
          .margin({ right: 10 })
        Text(this.userName).fontSize(20).fontWeight(FontWeight.Bold)
      }.width('100%').padding({ left: 15, right: 15 }).height(100).backgroundColor('#FfFfFf')

      Scroll(this.scroller) {
        Column() {
          this.linearWidget('Scroll组件结合属性动画实现导航背景色切换效果', SCROLLDHJB)
          this.linearWidget('List滚动吸顶', LISTHEADER)
        }
      }

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  linearWidget(title: string, routerUrl?: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 15, right: 15 })
        .onClick(() => {
          if (routerUrl) {
            router.pushUrl({ url: routerUrl })
          }
        })
    }.width('100%').height(50).margin({ top: 10 }).backgroundColor(Color.White)
  }
}
