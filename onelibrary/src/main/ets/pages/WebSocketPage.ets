import webSocket from '@ohos.net.webSocket'

@Entry
@Component
struct WebSocketPage {
  ws = webSocket.createWebSocket()
  isConnected: Boolean = false

  aboutToAppear() {
    let url = "ws://ip:port"
    this.ws.connect(url, (err, value) => {
      if (!err) {
        console.log('链接成功');
        this.isConnected = true
      } else {
        console.log('连接失败')
      }
    })
    //打开事件
    this.ws.on("open", (err, value) => {
      console.log("on open, status:" +value);
      // 当收到on('open')事件时，可以通过send()方法与服务器进行通信
    })
    //订阅消息事件
    this.ws.on("message", (error, value: string | ArrayBuffer) => {
      console.log("on message, message:" + value);
    })
  }

  build() {
    Column() {
      Button('发送')
        .width('100%')
        .height(60)
        .fontColor(Color.White)
        .backgroundColor(Color.Blue)
        .fontSize(18).onClick(()=>{
          this.ws.send("发送得内容",(err, value) => {
            if (!err) {
              console.log("send success");
            } else {
              console.log("send fail, err:" + JSON.stringify(err));
            }
          })
      })
    }.width('100%').height('100%')
  }
  aboutToDisappear(){
    this.ws.close()
  }
}