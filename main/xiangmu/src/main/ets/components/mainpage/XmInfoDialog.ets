import { TitlePage,ShowToast, WebEntity, WBE_PAGE_URL } from '@ohos/libWidght'
import { ProjectJsonData } from './entity/ProjectTreeJsonEntity'
import router from '@ohos.router'

@CustomDialog
@Component
export struct XmInfoDialog{
  projectJsonData:ProjectJsonData

  cancel: () => void = ()=>{
    console.info('Callback when the second button is clicked')
  }
  confirm: () => void = () => {
    console.info('Callback when the second button is clicked')
  }
  controller: CustomDialogController = new CustomDialogController({
    builder: XmInfoDialog({
      cancel: this.cancel,
      confirm: this.confirm,
    }),
    autoCancel: true,
    customStyle: true,
  })


  build(){
    Column(){
      TitlePage({title:this.projectJsonData.title,back:this.cancel})
      Stack(){
        Scroll(){
          Column(){
            Image(this.projectJsonData.envelopePic).objectFit(ImageFit.Contain)
            Text(this.projectJsonData.title).fontSize(18).fontWeight(FontWeight.Bold).margin({top:10,bottom:10})
            Text(this.projectJsonData.desc).fontSize(18)
            Text("git地址:"+this.projectJsonData.projectLink)
              .fontSize(16).margin({top:10,bottom:10}).fontColor('#ff00ff').decoration({type:TextDecorationType.Underline})
            Text("作者:"+this.projectJsonData.author).fontSize(16)
          }
          .width('100%').alignItems(HorizontalAlign.Start).padding({left:10,right:10})
        }.height('100%')
        .width('100%')
        .margin({bottom:55})
        Button("网页详情").width('100%').height(50).borderRadius(10).onClick(()=>{
          let paramsInfo:WebEntity = {
            url:this.projectJsonData.link,
            title:this.projectJsonData.title
          }
          router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo}).then((res)=>{
            this.cancel()
          }).catch((error)=>{

          })
        })

      }.alignContent(Alignment.Bottom).width('100%').layoutWeight(1)

    }.width('100%')
    .height('100%').backgroundColor('#ffffff')
  }
}