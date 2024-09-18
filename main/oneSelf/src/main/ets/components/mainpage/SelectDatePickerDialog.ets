@CustomDialog
@Component
export struct SelectDatePickerDialog{
  dialogController?:CustomDialogController
  private date: Date = new Date()
  selectData:(string)=>void
  close:()=>void
  @State
  private selectDateContent:string = ""
  build(){
    Column(){
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.date
      }).onChange((value)=>{
        console.log("index = "+value.year)
        console.log("index = "+value.month)
        console.log("index = "+value.day)
        this.selectDateContent = value.year+"-"+this.valueAndTen(value.month+1)+"-"+this.valueAndTen(value.day)
      })
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
          if (this.selectDateContent) {

          }else{
            this.selectDateContent = this.date.getFullYear()+"-"
                  +this.valueAndTen(this.date.getMonth()+1)+"-"+this.valueAndTen(this.date.getDate())
          }
          this.selectData(this.selectDateContent)
          this.close()
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
    }.width('100%')
    .height(250)
  }
  valueAndTen(value:number):string{
    let s_month:string
    if (value<10) {
      s_month = "0"+value
    }else{
      s_month = value.toString()
    }
    return s_month
  }
}