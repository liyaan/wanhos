
//商品类
class Goods1{
  static id:number = 1   //商品id
  name: string = `小米手机${Goods1.id++}`  //商品名称
  isSelected: boolean = false //商品在购物车中是否选中
}

@Entry
@Component
struct ArkTSBaseState {
  @State totalGoods:number = 0
  @State selectedGoods:number = 0
  @State goodsList:Goods1[] = []
  changeGoodsList(){
    this.totalGoods = this.goodsList.length
    this.selectedGoods = this.goodsList.filter(item=>item.isSelected).length
  }
  build() {
    Column({space:10}){
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
      }.card1()
      .margin({top:20,bottom:10})
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({top:20,bottom:10})
      Button('添加商品')
        .width(200)
        .onClick(() =>{
          //1.添加商品
          this.goodsList.push(new Goods1())
          this.changeGoodsList()
        })

      List({space:10}){
        //循环渲染,加载子组件
        ForEach(
          this.goodsList,
          (item:Goods1,index) =>{
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
                    //1.改变商品的选中的状态
                    item.isSelected = val
                    this.changeGoodsList()
                  })
              }.card1()
              .justifyContent(FlexAlign.SpaceAround)
            }.swipeAction({end:this.deleteButton(index)})

          }
        )


      }.width('100%')
      .layoutWeight(1)
      .divider({strokeWidth:2,color:'#36D',startMargin:10,endMargin:10})
      .alignListItem(ListItemAlign.Center)

    }.width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
  @Builder deleteButton(index:number){
    Button('删除').width(40)
    .height(40)
    .backgroundColor(Color.Red)
    .onClick(()=>{
      //1.从数组中删除商品
      this.goodsList.splice(index,1)
      //2.更新
      this.changeGoodsList()
    })
  }
}

@Styles function card1(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
}
@Extend(Text) function selectedGoods(){
  .fontColor(Color.Red)
  .fontWeight(FontWeight.Bold)
}