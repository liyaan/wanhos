@Entry
@Component
export struct TitlePage {
  back: () => void
  title: string

  build() {
    Row() {
      Image($r('app.media.title_left')).onClick(this.back).height(30).margin({ left: 15 })
      Text(this.title)
        .fontSize(18)
        .fontColor('#000')
        .fontWeight(FontWeight.Bold)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Text("").margin({ right: 15 })
    }.width('100%').height(45).backgroundColor('#ffffff').justifyContent(FlexAlign.SpaceBetween)
  }
}