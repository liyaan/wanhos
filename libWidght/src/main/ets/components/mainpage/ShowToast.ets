import promptAction from '@ohos.promptAction'
export class ShowToast{
  static show(message:string){
    let showToastOptions = {
      message:message,
      duration:1000,
      bottom:Alignment.Center
    }
    promptAction.showToast(showToastOptions)
  }
}