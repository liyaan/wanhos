import promptAction from '@ohos.promptAction'


export class ShowToastUtils{

  static show(message:string){
    promptAction.showToast({
      message:message,
      duration:1000,
      bottom:50
    })
  }
}

// export const showToastUtils = new ShowToastUtils();