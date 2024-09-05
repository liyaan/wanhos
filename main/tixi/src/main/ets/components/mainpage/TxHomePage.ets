@Component
export struct TxHomePage {
  @State message: string = '体系'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%').backgroundColor('#FFFFFF').width('100%')
  }
}
