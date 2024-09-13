import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { NaviJsonData, NaviJsonEntity } from './entity/NaviJsonEntity'
import { WBE_PAGE_URL, WebEntity } from  '@ohos/libWidght'
import router from '@ohos.router'
@Component
export struct DhMainPage {
  @State message: string = '导航'
  controller: TabsController
  @State currentIndex: number = 0
  private subController: TabsController = new TabsController()
  private panOptionRight: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Left })
  private panOptionLeft: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Right })
  @State naviJsonEntity: NaviJsonEntity[] = []
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'

  aboutToAppear() {
    this.getNaviJson()
  }

  getNaviJson() {
    api.getNaviJson<BaseEntity<Array<NaviJsonEntity>>>().then((result) => {
      this.naviJsonEntity = result.data
    })
  }

  build() {
    Column() {
      Tabs(
        { barPosition: BarPosition.Start, controller: this.subController, index: this.currentIndex }
      ) {
        ForEach(this.naviJsonEntity, (item: NaviJsonEntity, index) => {
          TabContent() {
            if (index == 0) {
              Column() {
                this.listJsonData(item.articles)
              }.width('100%').height('100%')
              // 左右拖动触发该手势事件
              .gesture(
                PanGesture(this.panOptionLeft)
                  .onActionStart((event?: GestureEvent) => {
                    console.info('Pan start')
                  })
                  .onActionUpdate((event?: GestureEvent) => {
                    if (event) {

                    }
                  })
                  .onActionEnd(() => {
                    this.controller.changeIndex(1)
                    console.info('Pan end')
                  })
              )
            } else if (index == this.naviJsonEntity.length - 1) {
              Column() {
                this.listJsonData(item.articles)
              }.width('100%').height('100%')
              // 左右拖动触发该手势事件
              .gesture(
                PanGesture(this.panOptionRight)
                  .onActionStart((event?: GestureEvent) => {
                    console.info('Pan start')
                  })
                  .onActionUpdate((event?: GestureEvent) => {
                    if (event) {

                    }
                  })
                  .onActionEnd(() => {
                    this.controller.changeIndex(3)
                    console.info('Pan end')
                  })
              )
            } else {
              this.listJsonData(item.articles)
            }

          }.tabBar(item.name)
        })
      }
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  listJsonData(articles: NaviJsonData[]) {
    Column() {
      List({ space: 8 }) {
        ForEach(articles, (item) => {
          ListItem() {
            Text(`${item.title}`)
              .width('100%')
              .fontSize(20)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .borderRadius(8)
              .backgroundColor(0x007DFF)
              .padding(10)
          }.onClick(()=>{
            let paramsInfo:WebEntity = {
              url:item.link,
              title:item.title
            }
            router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo})
          })
        })
      }.layoutWeight(1).padding({ left: 10, right: 10 })
    }
  }

  @Builder subTabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
    .height(50)
  }
}
