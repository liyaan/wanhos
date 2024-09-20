import { ARTICLELIST, BANNER_IMAGE_URL } from '../data/ContData'
import { ArticleItem } from '../entity/ArticleItem';


@Entry
@Component
struct ListTabScrollHeader {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @State totalScrollOffset: number = 0;
  private tabArray: number[] = [0, 1, 2]
  @State focusIndex: number = 0;
  private controller: TabsController = new TabsController()
  scroller: Scroller = new Scroller()
  @State scrollerFlag: boolean = false
  @State ARTICLELIST_M: ArticleItem[] = ARTICLELIST
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
      Stack({ alignContent: Alignment.TopStart }) {
        Scroll(this.scroller) {
          Column({ space: 10 }) {
            this.headerSwiper()
            if (!this.scrollerFlag)
              this.myScroll()
            ForEach(this.ARTICLELIST_M, (item) => {
              this.newsItem(item)
            })
          }.justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }.onScroll((xOffset: number, yOffset: number) => {
          console.log("yOffset = "+yOffset+"  "+JSON.stringify(this.scroller.currentOffset()))
          if (this.scroller.currentOffset().yOffset >= 260) {
            this.scrollerFlag = true
          } else {
            this.scrollerFlag = false
          }
        })
        if (this.scrollerFlag){
          this.myScroll()
        }

      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  headerSwiper() {
    Swiper() {
      ForEach(BANNER_IMAGE_URL, (item) => {
        Image(item).borderRadius(10).objectFit(ImageFit.Fill).width('100%').height(260)
      })
    }
    .autoPlay(true)
    .height(260)
    .duration(1000)
    .itemSpace(10)
    .index(1)
    .curve(Curve.Linear)
    .onChange((index) => {
      console.log("index = " + index)
    })
    .indicatorStyle({
      color: '#ffffff'
    })
  }

  @Builder newsItem(item: ArticleItem) {
    Row() {
      Column() {
        Text(item.title+this.focusIndex)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(20)
        Text(item.author + "  " + item.date)
          .fontSize(14)
          .lineHeight(18)
      }.layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .height(80)
      .justifyContent(FlexAlign.SpaceBetween)

      Image(item.img)
        .width(100)
        .height(80)
        .objectFit(ImageFit.Contain)
        .borderWidth(2)
        .borderColor(Color.Green)
        .borderRadius(5)
    }.width('100%')
    .height(100)
  }
  // 自定义构建函数
  @Builder topBar() {
    Row() {
      Row() {
        Text("图片新闻")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width("100%")
          .fontColor(0xffffff)
      }
      .layoutWeight(1)
      .height("100%")
    }
    .height(60)
    .width("100%")
    .backgroundColor(this.scrollerFlag ? Color.Green : Color.Transparent)
    .animation({ duration: 500 })
  }
}