import inputMethod from '@ohos.inputMethod';
@Observed
export class MessageBean {
    leftMessage?: string
    rightMessage?: string
}

@Component
struct ChatView {
  @ObjectLink messageBean: MessageBean;
  build() {
    Column(){
      if (this.messageBean.rightMessage!=undefined){
        Row(){
          Text(this.messageBean.rightMessage)
            .margin({right:10})
         this.imageLogo("user_logo")
        }.width("100%")
        .justifyContent(FlexAlign.End)
        .padding({ right: 10 })
      }else{
        Row() {
          this.imageLogo("user_logo_1")
          Text(this.messageBean.leftMessage)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Top)
        .padding({ right: 20 })
      }
    }
  }
  @Builder
  imageLogo(id:string){
    Image($r("app.media.icon"))
      .id(id)
      .border({color:Color.Red,width:1,radius:20})
      .width(20)
      .height(20)
  }
}

@Entry
@Component
struct ChatIndexView{
  private scroller: Scroller = new Scroller()
  @State sendMessage: string = ""
  @State messageList: Array<MessageBean> = []
  intervalID?: number
  private isEnd: boolean = true

  // aboutToAppear(): void {
  //   this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
  // }  api10以上
  // aboutToDisappear(): void {
  //   this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET);
  // }
  doHttp(success:(message:string)=>void){
    let data = "具体的实现效果，根据业务情况而定，有两种模式，一种主动的流式输出，也就是数据以流式的形式进行返回，前端直接用组件加载即可，第二种就是刻意的流式展示，也就是在拿到数据之后，前端实现流式输出，进行打字机展示。";
    let position: number = 0
    this.intervalID = setInterval(()=>{
      position = position+2;
      let message = data.substring(0,position);
      if (success != undefined) {
        success(message)
      }
      if (message.length >= data.length) {
        this.isEnd = true//模拟结束
        clearInterval(this.intervalID)
      }
    },100)
  }

  build(){
    Column() {
      List({ space: 10, scroller: this.scroller }) {
        ForEach(this.messageList, (item: MessageBean) => {
          ListItem() {
            ChatView({ messageBean: item })
          }
        })
      }.margin({ top: 10 })
      .layoutWeight(1)
      //输入框顶起布局 api9 解决办法 点击发送后隐藏输入框

      //.expandSafeArea([SafeAreaType.KEYBOARD]) 标题组件不避让键盘 api10以上
      Row() {
        TextInput({ placeholder: "请输入问题" ,text:this.sendMessage})
          .onChange((text) => {
            this.sendMessage = text
          }).layoutWeight(1)

        Button("发送")
          .width(100)
          .margin({ left: 10 })
          .onClick(() => {
          //发送
          if (this.isEnd) {

            this.isEnd = false
            let bean = new MessageBean()
            bean.rightMessage = this.sendMessage
            this.messageList.push(bean)
            this.scroller.scrollEdge(Edge.Bottom)
            //模拟接口返回数据
            let leftBean = new MessageBean()
            this.messageList.push(leftBean)
            this.sendMessage = ""
            focusControl.requestFocus("Button")
            let inputMethodController = inputMethod.getController();
            inputMethodController.stopInputSession();
            this.doHttp((content) => {
              leftBean.leftMessage = content
            })
          }

        })
      }
      .height(40)
      .padding({ left: 10, right: 10 })
      .backgroundColor(Color.White)

    } .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Start)
  }
}