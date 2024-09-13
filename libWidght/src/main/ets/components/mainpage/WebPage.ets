import { TitlePage } from './TitlePage'
import router from '@ohos.router'
import webview from '@ohos.web.webview'
import { WebEntity } from './WebEntity'

@Entry
@Component
export struct WebPage {
  controller: webview.WebviewController = new webview.WebviewController();
  @State progress: number = 0
  @State showProgress: boolean = true
  @State webEntity: WebEntity = null

  aboutToAppear() {
    this.webEntity = router.getParams() as WebEntity
  }

  build() {
    Column() {
      TitlePage({ title: this.webEntity.title, back: () => {
        router.back()
      } })
      if (this.showProgress) {
        Progress({ value: this.progress, total: 100, type: ProgressType.Linear }).width('100%')
      }
      if (this.webEntity.url){
        Web({ src: this.webEntity.url, controller: this.controller })
          .width('100%')
          .height('100%')
          .javaScriptAccess(true)
          .multiWindowAccess(true)
          .domStorageAccess(true)
          .mediaPlayGestureAccess(true)
          .onlineImageAccess(true)
          .fileAccess(true)
          .onProgressChange((progress) => {
            console.log("webview number = " + progress.newProgress)
            this.progress = progress.newProgress
            if (progress.newProgress >= 0 && progress.newProgress < 100) {
              this.showProgress = true
            } else if (progress.newProgress == 100) {
              this.showProgress = false
            }
          })
          .onConsole((message) => {
            console.log("webview" + message.message.getMessage() + "  " + message.message.getLineNumber())
            return true
          })
          .onTitleReceive((info) => {
            console.log('webview 标题: ' + info.title)
          })
          .onUrlLoadIntercept((info) => {
            if (!info.data.toString().toLowerCase().startsWith("https://") || !info.data.toString()
              .toLowerCase()
              .startsWith("https://")) {
              console.log('webview 拦截信息: ' + JSON.stringify(info))
              return true;
            }
            //false : 不拦截   true: 拦截
            return false
          })
          .onErrorReceive((error) => {
            console.log("webview "+error.request.getRequestUrl())
            console.log("webview "+JSON.stringify(error.error))
          })
          .onHttpErrorReceive((error) => {
            console.log("webview "+JSON.stringify(error.response))
          })
      }else{
        Column(){
          Text("Url地址不能为空").fontColor('#000').fontSize(20)
        }.width('100%').layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
      }

    }.width('100%')
    .height('100%')
  }
  aboutToDisappear(){
    this.controller.clearHistory()
  }
}