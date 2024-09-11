
import * as size from './theme/size';
import {MainHome} from '@ohos/home'
import {TxHomePage} from '@ohos/tixi'
import {DhMainPage} from '@ohos/daohang'
import {XmMainPage} from '@ohos/xiangmu'
import {OneMainPage} from '@ohos/oneSelf'
@Entry
@Component
export struct Main {
  @State currentIndex: number = 0
  private tabsController: TabsController = new TabsController()

  build() {
    Stack() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        TabContent() {
          MainHome()
        }.tabBar(this.tabBuilder("首页",0,$r('app.media.tab_home'),$r('app.media.tab_home_1')))

        TabContent() {
          TxHomePage()
        }.tabBar(this.tabBuilder("体系",1,$r('app.media.tab_myclass'),$r('app.media.tab_myclass_1')))

        TabContent() {
          DhMainPage({controller:this.tabsController})
        }.tabBar(this.placehostBuilder())

        TabContent() {
          XmMainPage()
        }.tabBar(this.tabBuilder("项目",3,$r('app.media.tab_xielie'),$r('app.media.tab_xielie_1')))

        TabContent() {
          OneMainPage()
        }.tabBar(this.tabBuilder("我的",4,$r('app.media.tab_my'),$r('app.media.tab_my_1')))
      }
      .onChange((index:number)=>{
        this.currentIndex = index
      }).backgroundColor('#fff7f7f7')
      .barHeight(size.barHeight)
      .barMode(BarMode.Fixed)

      Image(this.currentIndex === 2 ? $r("app.media.center_add") : $r('app.media.add_ed'))
        .margin({bottom:10})
        .height(60)
        .alignSelf(ItemAlign.Center)// 设置悬浮图标居中对齐
        .borderRadius(size.bigAvaterSize + size.miniPadding * 2)
        .backgroundColor('#fff7f7f7')
        .onClick(()=>{
          this.tabsController.changeIndex(2)
        })
        // .border({
        //   width: size.miniPadding,
        //   style: BorderStyle.Solid
        // })
    }.align(Alignment.Bottom).width('100%')
    .height('100%').backgroundColor('#ffffff')
  }

  @Builder
  tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg).size({width:25,height:25})
      Text(title).fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }.width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }
  @Builder placehostBuilder(){
    Row()
  }
}