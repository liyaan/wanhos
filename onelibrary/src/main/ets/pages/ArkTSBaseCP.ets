
//商品类
class Goods{
  static id:number = 1   //商品id
  name: string = `小米手机${Goods.id++}`  //商品名称
  isSelected: boolean = false //商品在购物车中是否选中
}

@Entry
@Component
struct ArkTSBaseCP {
  @Provide totalGoods:number = 0
  @Provide selectedGoods:number = 0

  build() {
    Column({space:10}){
      TitleComp()
      ListGoods()

    }.width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

}
@Component
struct TitleComp{
  @Consume totalGoods:number
  @Consume selectedGoods:number
  build(){
    Row(){
      Text('购物车').fontSize(18)
      Stack(){
        Progress({value:this.selectedGoods,total:this.totalGoods,type:ProgressType.Ring})
        Row(){
          Text(this.selectedGoods.toString())
            .fontSize(24)

          Text('/'+this.totalGoods)
            .fontSize(24)
        }
      }
    }.card()
    .margin({top:20,bottom:10})
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({top:20,bottom:10})
  }
}
@Component
struct ListGoods{
  @State goodsList: Goods[] = []
  @Consume totalGoods:number
  @Consume selectedGoods:number
  build(){
    Column(){
      Button('添加商品')
        .width(200)
        .onClick(()=>{
          this.goodsList.push(new Goods())
          // this.totalGoods = this.goodsList.length
          this.handlerGoodsItem()
        })
      List({space:10}){
        ForEach(
          this.goodsList,
          (item:Goods,index:number) =>{
            ListItem(){
              Row(){
                if(item.isSelected){
                  Text(item.name)
                    .fontSize(20)
                }else{
                  Text(item.name)
                    .fontSize(20)
                }

                Checkbox()
                  .select(item.isSelected)
                  .onChange(val=>{
                    item.isSelected = val
                    this.handlerGoodsItem()
                  })
              }.card()
              .justifyContent(FlexAlign.SpaceAround)
            }.swipeAction({end:this.deleteButton(index)})

          }
        )



      }.width('100%')
      .layoutWeight(1)
      .divider({strokeWidth:2,color:'#36D',startMargin:10,endMargin:10})
      .alignListItem(ListItemAlign.Center)
    }.alignItems(HorizontalAlign.Center)
    .width('100%')
  }
  handlerGoodsItem(){
    this.totalGoods = this.goodsList.length
    this.selectedGoods = this.goodsList.filter(item=>item.isSelected).length
  }
  @Builder deleteButton(index:number){
    Button('删除').width(40)
      .height(40)
      .backgroundColor(Color.Red)
      .onClick(()=>{
        //1.从数组中删除商品
        this.goodsList.splice(index,1)
        //2.更新
        this.handlerGoodsItem()
      })
  }
}
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
}
// @Extend(Text) function selectedGoodsStyle(){
//   .fontColor(Color.Red)
//   .fontWeight(FontWeight.Bold)
// }