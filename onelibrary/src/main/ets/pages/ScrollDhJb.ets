import { ARTICLELIST, BANNER_IMAGE_URL } from '../data/ContData'
import { ArticleItem } from '../entity/ArticleItem'

@Entry
@Component
struct ScrollDhJb {
  @State message: string = 'Hello World'
  scroller: Scroller = new Scroller()
  @State scrollerFlag: boolean = false

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Scroll(this.scroller) {
          Column({ space: 10 }) {
            this.headerSwiper()
            ForEach(ARTICLELIST, (item) => {
              this.newsItem(item)
            })
          }.justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }.onScroll((xOffset: number, yOffset: number) => {
          console.log("yOffset = "+yOffset+"  "+JSON.stringify(this.scroller.currentOffset()))
          if (this.scroller.currentOffset().yOffset >= 100) {
            this.scrollerFlag = true
          } else {
            this.scrollerFlag = false
          }
        })

        this.topBar()
      }
    }
    .width('100%')
    .height('100%')
  }
  ////1.轮播组件Swiper基本用法
  // Swiper() {
  //   //编写需要轮播的内容(可配合其他容器组件使用,如Column,Row,Text,Image等)
  // }
  // //2.通用属性:宽,高,背景一系列属性,圆角,边框
  // .width('100%')//设置轮播宽度
  // .height('100%')//设置轮播高度
  // .backgroundColor( )//设置背景颜色
  // .border({width:,color:,style:})//设置边框
  // .borderRadius( )//设置圆角
  // //3.轮播组件Swiper基本属性
  // .loop(false)//设置轮播的循环,true:循环(默认),false:不循环
  // .autoPlay(true)//设置自动轮播,true:自动,false:不自动(默认)
  // .interval(0)//设置轮播延迟
  // .vertical(true)//设置轮播滚动方向，true:纵向滚动,false:横向滚动(默认)
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
        Text(item.title)
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

@Extend(Text)
function itemTv() {

}