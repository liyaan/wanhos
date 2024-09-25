/**
 * @ObjectLink和@Observed类装饰器用于在涉及嵌套对象或数组的场景中进行双向数据同步
 *
 * */
@Observed
class GoodsOlo{
  id:number = 1   //商品id
  name: string  //商品名称
  isSelected: boolean = false //商品在购物车中是否选中
  constructor(id:number,name:string) {
    this.name = name+id
  }
}

class CarInfo{
  //购物车中的总商品数
  totalGoods:number = 0

  //购物车中选中的商品数
  selectedGoods:number = 0
}

@Entry
@Component
struct ArkTSBaseOLO {
  @Provide carInfo:CarInfo = new CarInfo()

  build() {
    Column({space:10}){
      TitleComp1()
      ListGoods1()

    }.width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

}
@Component
struct TitleComp1{
  @Consume carInfo:CarInfo
  build(){
    Row(){
      Text('购物车:')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({value:this.carInfo.selectedGoods,total:this.carInfo.totalGoods,type:ProgressType.Ring})
        Row(){
          Text(this.carInfo.selectedGoods.toString())
            .fontSize(24)

          Text('/'+this.carInfo.totalGoods)
            .fontSize(24)
        }
      }

    }.cardOlo()
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({top:20,bottom:10})
  }
}
@Component
struct ListGoods1{
  @State goodsList: GoodsOlo[] = []
  @Consume carInfo:CarInfo
  build(){
    Column(){
      Button('添加商品')
        .width(200)
        .onClick(() =>{
          //1.添加商品
          this.goodsList.push(new GoodsOlo(this.goodsList.length+1,"小米手机"))
          this.changeGoodsList()
        })

      //3.购物车中商品列表
      List({space:10}){
        //循环渲染,加载子组件
        ForEach(
          this.goodsList,
          (item:GoodsOlo,index) =>{
            ListItem(){
              GoodsItem({item:item,onChangeCar:this.changeGoodsList.bind(this)})
            }.swipeAction({end:this.deleteButton(index)})

          }
        )


      }.width('100%')
      .layoutWeight(1)
      .divider({strokeWidth:2,color:'#36D',startMargin:10,endMargin:10})
      .alignListItem(ListItemAlign.Center)
    }
  }
  changeGoodsList(){
    //1.购物车商品的总数加1
    this.carInfo.totalGoods = this.goodsList.length

    //2.更新购物车中选中的商品数
    this.carInfo.selectedGoods = this.goodsList.filter(item=>item.isSelected).length

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

@Component
struct GoodsItem {
  @ObjectLink item: GoodsOlo
  onChangeCar: () => void
  build() {
    Row(){
      if(this.item.isSelected){
        Text(this.item.name)
          .fontSize(20)
          .selectedGoodsStyle()
      }else{
        Text(this.item.name)
          .fontSize(20)
      }

      Checkbox()
        .select(this.item.isSelected)
        .onChange(val=>{
          //1.改变商品的选中的状态
          this.item.isSelected = val
          // this.changeGoodsList()
          this.onChangeCar()
        })
    }.cardOlo()
    .justifyContent(FlexAlign.SpaceAround)
  }
}

@Styles function cardOlo(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
}
@Extend(Text) function selectedGoodsStyle(){
  .fontColor(Color.Red)
  .fontWeight(FontWeight.Bold)
}