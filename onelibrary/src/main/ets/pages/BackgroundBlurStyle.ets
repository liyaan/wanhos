//为当前组件提供一种在背景和内容之间的模糊能力，通过枚举值的方式封装了不同的模糊半径、蒙版颜色、蒙版透明度、饱和度、亮度
/*
 *
value: 背景模糊样式。模糊样式中封装了模糊半径、蒙版颜色、蒙版透明度、饱和度、亮度五个参数。
backgroundBlurStyle(value: BlurStyle)
 * */
@Entry
@Component
struct BackgroundBlurStyle {
  build() {
    Grid() {
      GridItem() {
        Column() {
          Column() {
            this.commonText('原图')
          }.CommonColumn()
         this.commonTitle('原图')
        }.height('100%')
        .justifyContent(FlexAlign.Start)
      }.width(200)
      .height(200)

      GridItem() {
        Column() {
          Column() {
            this.commonText('Thin')
          }.backgroundBlurStyle(BlurStyle.Thin).CommonColumn()
          this.commonTitle('Thin')
        }.height('100%')
        .justifyContent(FlexAlign.Start)
      }.width(200)
      .height(200)

      GridItem() {
        Column() {
          Column() {
            this.commonText('Regular')
          }.backgroundBlurStyle(BlurStyle.Regular).CommonColumn()
          this.commonTitle('Regular')
        }.height('100%')
        .justifyContent(FlexAlign.Start)
      }.width(200)
      .height(200)

      GridItem() {
        Column() {
          Column() {
            this.commonText('Thick')
          }.backgroundBlurStyle(BlurStyle.Thick).CommonColumn()
          this.commonTitle('Thick')
        }.height('100%')
        .justifyContent(FlexAlign.Start)
      }.width(200)
      .height(200)


    }.columnsTemplate('1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .width('100%')
    .height('100%')
    .margin({ top: 40 })
  }
  @Builder
  commonText(content){
    Text(content)
      .width('100%')
      .height('100%')
      .fontSize(20)
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
  }
  @Builder
  commonTitle(content){
    Text(content)
      .fontSize(12)
      .fontColor(Color.Black)
  }
}
@Extend(Column)
function CommonColumn(){
  .height(100)
  .aspectRatio(1)
  .borderRadius(10)
  .backgroundImage($r('app.media.cesh'))
}
