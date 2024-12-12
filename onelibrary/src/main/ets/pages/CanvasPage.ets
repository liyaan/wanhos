@Entry
@Component
struct CanvasPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  // 转换为弧度值
  private getAngle(n: number) {
    return Math.PI / 180 * n;
  }
  private drawCircleText(text: string) {
    const width = this.context.width, height = this.context.height;
    const fontSize = 18;
    const r = width/2-fontSize;
    this.context.clearRect(0,0,width,height)
    this.context.save()
    this.context.font = `${fontSize}vp`
    this.context.textBaseline = 'top'
    const charRadius = 360/text.length
    this.context.translate(width/2,height/2)
    for (let index = 0; index < text.length; index++) {
      this.context.fillText(text.charAt(i),0,-r)
      this.context.rotate(this.getAngle(charRadius))
    }
    this.context.restore();
  }
  build(){
    Row() {
      Column() {
        Canvas(this.context)
          .width(300)
          .height(300)
          .borderColor('green')
          .borderWidth(1)
          .onReady(() => this.drawCircleText('欢迎加入Harmony鸿蒙'))
      }
      .width('100%')
    }
    .height('100%');
  }
}