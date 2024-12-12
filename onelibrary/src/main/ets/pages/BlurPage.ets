@Entry
@Component
struct BlurPage {
  @State radius: number = 0;
  @State text: string = '';
  @State y: string = '手指不在屏幕上';

  aboutToAppear() {
    this.text = "按住屏幕上下滑动\n" + "当前手指所在y轴位置 ：" + this.y +
    "\n" + "当前图片模糊程度为 : " + this.radius;
  }
  build() {
    // Column({ space: 10 }) {
    //   Text("backdropBlur背景模糊")
    //     .width('90%')
    //     .height('90%')
    //     .fontSize(20)
    //     .fontColor(Color.White)
    //     .textAlign(TextAlign.Center)
    //     .backdropBlur(10)
    //     .backgroundImage($r('app.media.cesh'))
    //     .backgroundImageSize({ width: 400, height: 300 })
    // }.width('100%')
    // .height('50%')
    // .margin({ top: 20 })

    //-----------------------blur------------------------------
    Flex({direction:FlexDirection.Column,alignItems:ItemAlign.Center,justifyContent: FlexAlign.SpaceBetween }){
      Text(this.text)
        .height(200)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
      Image($r('app.media.cesh'))
        .blur(this.radius)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
    }.width('100%')
    .height('100%')
    .onTouch((event?: TouchEvent) => {
      if (event) {
        if (event.type === TouchType.Move) {
          this.y = Number(event.touches[0].y.toString()).toString()
          this.radius = Number(this.y)/10
        }
        if (event.type === TouchType.Up) {
          this.radius = 0;
          this.y = '手指离开屏幕';
        }
      }
      this.text = "按住屏幕上下滑动\n" + "当前手指所在y轴位置 ：" + this.y +
      "\n" + "当前图片模糊程度为 : " + this.radius;
    })
  }
}