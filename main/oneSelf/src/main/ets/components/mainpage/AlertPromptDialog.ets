@CustomDialog
@Component
export struct AlertPromptDialog{
  dialogController?:CustomDialogController
  close:()=>void
  contents: string
  submit:()=>void
  build(){
    Column(){
      Row(){
        Text(this.contents).fontSize(18).fontColor(Color.Black)
          .lineHeight(24)
      }.alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .padding({left:10,top:15,right:10,bottom:15})
      Row(){
        Row(){
          Text("确认")
            .fontColor('rgb(0,122,255)')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }.justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1)
        .height(50)
        .onClick(()=>{
          this.submit()
        })
        Row(){
          Text("取消")
            .fontColor(Color.Gray)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }.justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1)
        .height(50)
        .onClick(()=>{
          this.close()
        })
      }.width('100%')
      .height(50)
    }
  }
}