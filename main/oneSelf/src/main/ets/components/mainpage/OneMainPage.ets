import  { preferenceUtil,Constants} from '@ohos/httpUtils'
@Component
export struct OneMainPage {
  @State userName:string = ""
  @State passWord:string = ""

  aboutToAppear(){
    // preferenceUtil.readString(Constants.USERNAME).then((result)=>{
    //   this.userName = result
    // })
  }
  build() {
    Column() {
      Row(){
        Text(this.userName).fontSize(20).fontWeight(FontWeight.Bold)
      }.width('100%')
      .height(100).backgroundColor('#FfFfFf')
    }
    .width('100%')
    .height('100%')
  }
}
