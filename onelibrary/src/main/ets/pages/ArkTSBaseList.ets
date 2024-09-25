@Entry
@Component
struct ArkTSBaseList {

  //定义具体的商品,实际上就是数据源
  private items: Array<Item> = [
    new Item('华为mateX3','https://res1.vmallres.com/pimages/uomcdn/CN/pms/202404/displayProduct/26010104865/group/800_800_E724CF0DF33139A3F93291DCF3E272CB.jpg',13888,1000),
    new Item('华为mate60Pro','https://res1.vmallres.com/pimages/uomcdn/CN/pms/202404/displayProduct/26010104865/group/800_800_E724CF0DF33139A3F93291DCF3E272CB.jpg',6888,100),
    new Item('小米14','https://res1.vmallres.com/pimages/uomcdn/CN/pms/202407/displayProduct/26010104865/group/800_800_5EA2EF3E2A434DF4380636F868DA6F3B.jpg',4999)

  ]
  build() {
    Column() {
      Header({title:'商品列表',setting:true})
      Header({title:'商品列表',setting:false})
      // Row(){  //title部分
      //   Text('商品列表').fontSize(18)
      //     .fontWeight(FontWeight.Bold)
      // }.width('100%')
      // .height(45).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)
      List({space:10}){
        //循环渲染数据
        ForEach(this.items,(item:Item)=>{
          ListItem() { //商品部分1
            //第五版
            this.ShopListBuilderStyleExtend(item)
            //第四版
            // ShopListBuilder(item)
            //第三版
            // this.ShopListBuilder(item)
            //第二版 自定义组件
            // ShopList({item:item})
            // 第一版 数据展示
            // Row({space:10}){  //商品部分1
            //   Image(item.image)
            //     .width('35%')//商品图片
            //   Column(){
            //     if(item.discount){  //判断,如果非0 就是true 如果商品有打折,4个text组件
            //       Text(item.name)
            //         .fontSize(20)
            //         .fontWeight(FontWeight.Bold)
            //       Text('原价¥  '+ item.price)
            //         .fontSize(18)
            //         .fontColor('#F36')
            //         .decoration({type:TextDecorationType.LineThrough})
            //       Text('折后价¥ '+ (item.price-item.discount))
            //         .fontSize(18)
            //         .fontWeight(FontWeight.Bold)
            //         .fontColor('#F36')
            //       Text('补贴¥ '+ item.discount)
            //         .fontSize(18)
            //         .fontColor('#F36')
            //     }else{ //商品不打折,2个text组件
            //       Text(item.name)
            //         .fontSize(20)
            //         .fontWeight(FontWeight.Bold)
            //       Text('¥ '+ item.price)
            //         .fontSize(18)
            //         .fontColor('#F36')
            //     }
            //
            //   }.height('100%')
            //   .alignItems(HorizontalAlign.Center)
            // }.width('100%')
            // .backgroundColor('#FFF')
            // .borderRadius(20)
            // .height(120)
          }
        })
      }.width('100%')
      .layoutWeight(1)//权重
      .margin(10)
      .listDirection(Axis.Vertical)  // Axis.Vertical默认的排列方式  垂直方向      Axis.Horizontal水平方向
      .divider({strokeWidth:2,color:'#36D',startMargin:10,endMargin:10})
    }.width('100%')
    .height('100%')
  }
  @Builder
  ShopListBuilder(item:Item){
    Row({space:10}){
      Image(item.image).width('35%')
      Column(){
        if (item.discount){
          Text(item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('原价¥  '+ item.price)
            .fontSize(18)
            .fontColor('#F36')
            .decoration({type:TextDecorationType.LineThrough})
          Text('折后价¥ '+ (item.price-item.discount))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F36')
          Text('补贴¥ '+ item.discount)
            .fontSize(18)
            .fontColor('#F36')
        }else{ //商品不打折,2个text组件
          Text(item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('¥ '+ item.price)
            .fontSize(18)
            .fontColor('#F36')
        }
      }.height('100%')
      .justifyContent(FlexAlign.Center)
    }.width('100%')
    .height(120)
  }
  @Builder
  ShopListBuilderStyleExtend(item:Item){
    Row({space:10}){
      Image(item.image).width('35%')
      Column(){
        if (item.discount){
          Text(item.name)
            .priceStyle(20,Color.Black)
          Text('原价¥  '+ item.price)
            .priceStyle(18,'#F36')
            .decoration({type:TextDecorationType.LineThrough})
          Text('折后价¥ '+ (item.price-item.discount))
            .fontWeight(FontWeight.Bold)
            .priceStyle(18,'#F36')
          Text('补贴¥ '+ item.discount)
            .priceStyle(18,'#F36')
        }else{ //商品不打折,2个text组件
          Text(item.name)
            .priceStyle(20,Color.Black)
            .fontWeight(FontWeight.Bold)
          Text('¥ '+ item.price)
            .priceStyle(18,'#F36')
        }
      }.height('100%')
      .justifyContent(FlexAlign.Center)
    }.myStylesFunction()
  }
}
//全局样式 样式
@Styles function myStylesFunction(){
  .width('100%')
  .height(120)
}

//扩展原生组件样式
@Extend(Text) function priceStyle(size: number,color: ResourceColor){
  .fontSize(size)
  .fontWeight(FontWeight.Bold)
  .fontColor(color)
}

@Builder function  ShopListBuilder(item:Item){
  Row({space:10}){
    Image(item.image).width('35%')
    Column(){
      if (item.discount){
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('原价¥  '+ item.price)
          .fontSize(18)
          .fontColor('#F36')
          .decoration({type:TextDecorationType.LineThrough})
        Text('折后价¥ '+ (item.price-item.discount))
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F36')
        Text('补贴¥ '+ item.discount)
          .fontSize(18)
          .fontColor('#F36')
      }else{ //商品不打折,2个text组件
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('¥ '+ item.price)
          .fontSize(18)
          .fontColor('#F36')
      }
    }.height('100%')
    .justifyContent(FlexAlign.Center)
  }.width('100%')
  .height(120)
}
//定义一个类 这个类代表的就是数据源数据

class Item {
  name: string  //商品名称
  image: ResourceStr  //图片地址
  price: number  //商品价格
  discount: number  //商品折扣

  //构造函数  用来实例化商品对象 商品打折默认为0
  constructor(name:string,image:ResourceStr,price:number,discount:number=0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }

}

@Component
struct ShopList{
  private item:Item
  build(){
    Row({space:10}){
      Image(this.item.image)
        .width('35%')//商品图片
      Column(){
        if(this.item.discount){  //判断,如果非0 就是true 如果商品有打折,4个text组件
          Text(this.item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('原价¥  '+ this.item.price)
            .fontSize(18)
            .fontColor('#F36')
            .decoration({type:TextDecorationType.LineThrough})
          Text('折后价¥ '+ (this.item.price-this.item.discount))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F36')
          Text('补贴¥ '+ this.item.discount)
            .fontSize(18)
            .fontColor('#F36')
        }else{ //商品不打折,2个text组件
          Text(this.item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('¥ '+ this.item.price)
            .fontSize(18)
            .fontColor('#F36')
        }
      }.alignItems(HorizontalAlign.Center)
      .height('100%')
    }.width('100%')
    .backgroundColor('#FFF')
    .borderRadius(20)
    .height(120)

  }
}
@Component
struct Header{
  private title:string
  private setting:boolean
  build(){
    Row(){  //title部分
      Image($r('app.media.title_left'))
        .width(30)
        .height(40)
        .interpolation(ImageInterpolation.High)
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      Blank()
      if (this.setting){
        Image($r('app.media.setting'))
          .width(30)
          .interpolation(ImageInterpolation.High)
      }

    }.width('100%')
    .padding({left:15,right:15})
    .alignItems(VerticalAlign.Center)
    .height(50)
  }
}