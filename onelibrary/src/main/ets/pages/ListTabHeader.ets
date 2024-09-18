import { ARTICLELIST } from '../data/ContData'
import { ArticleItem } from '../entity/ArticleItem';
import { ArticleList } from '../entity/HosDataEntity'

@Entry
@Component
struct ListTabHeader {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @State totalScrollOffset: number = 0;
  private tabArray: number[] = [0, 1, 2]
  @State focusIndex: number = 0;
  private controller: TabsController = new TabsController()
  scroller: Scroller = new Scroller()
  @Builder
  myScroll() {
    Scroll() {
      Row() {
        //ListItemGroup的吸顶，点击穿透
        ForEach(this.tabArray, (item: number, index: number) => {
          Row({ space: 20 }) {
            Text('页签' + item)
              .fontWeight(index === this.focusIndex ? FontWeight.Bold : FontWeight.Normal)
          }
          .padding({ left: '10fp', right: '10fp' })
          .onClick(() => {
            console.log("index = "+index)
            // this.controller.changeIndex(index)
            this.focusIndex = index
          }).width('33%').alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)
          .height(40).backgroundColor('#fff').onTouch((even)=>{
            console.log("index even.type = "+even.type)
          }).hitTestBehavior(HitTestMode.Block)
        })
      }
    }
    .align(Alignment.Start)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  build() {
    Column() {
      List({ space: 20, initialIndex: 0 ,scroller:this.scroller}) {
        ForEach(this.arr, (item: number) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(100)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0xFFFFFF)
          }
        }, (item: string) => item)
        ListItemGroup({ header:this.myScroll() }) {
          ListItem() {
            List(){
              ForEach(ARTICLELIST, (item: ArticleItem) => {
                ListItem(){
                  Text(item.title + this.focusIndex).width('100%').height(100).align(Alignment.Center)
                    .onClick(()=>{
                      console.log("index content="+item.title+this.focusIndex)
                    })
                }
              })
            }.layoutWeight(1).zIndex(0)
            //tabs组件把tabbar隐藏
            // Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
            //   ForEach(this.tabArray, (item: number, index: number) => {
            //     TabContent() {
            //       Text('我是页面 ' + item + " 的内容")
            //         .fontSize(30)
            //     }
            //   })
            // }.width('100%')
            // .onChange((index)=>{
            //   this.focusIndex = index
            // })
            // .height('100%')
            // .barHeight(0)
          }
        }
      }
      .sticky(StickyStyle.Header)
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.None)
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        console.info('first' + firstIndex)
        console.info('last' + lastIndex)
      })
      .onScroll((scrollOffset: number, scrollState: ScrollState) => {
        console.info(`onScroll scrollState = ScrollState` + scrollState + `, scrollOffset = ` + scrollOffset)
        this.totalScrollOffset += scrollOffset
        console.log('yeyouzhi>>>' + this.totalScrollOffset)
      })
      .width('90%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}