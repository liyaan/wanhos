import { TitlePage,ShowToast } from '@ohos/libWidght'
import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { ListJsonData, TreeJsonList } from './entity/TreeJsonList'
@CustomDialog
@Component
export struct TxSecondDialog{
  @State listJsonData:ListJsonData[] = []
  cid:number
  title:string
  cancel: () => void = ()=>{
    console.info('Callback when the second button is clicked')
  }
  confirm: () => void = () => {
    console.info('Callback when the second button is clicked')
  }
  controller: CustomDialogController = new CustomDialogController({
    builder: TxSecondDialog({
      cancel: this.cancel,
      confirm: this.confirm,
    }),
    autoCancel: true,
    customStyle: true,
  })

  @State
  private refreshingFlag: boolean = false;
  @State
  private page: number = 0
  // 判断滚动条是否触底
  @State
  private isEnd: boolean = false;
  // 使用Scroller对象
  private scroller: Scroller = new Scroller();
  aboutToAppear(){
    this.getDataList()
  }
  getDataList(){
    api.listJson<BaseEntity<TreeJsonList>>(this.page,this.cid).then((result)=>{
      if (this.page === 0) {
        if (this.listJsonData.length > 0) {
          this.listJsonData = []
        }
      }
      if (result.data.pageCount>this.page) {
        this.listJsonData.push(...result.data.datas)
      }else{
        ShowToast.show("暂无更多数据")
      }

    })
  }
  build(){
    Column(){
      TitlePage({title:this.title,back:this.cancel})
      Refresh({ refreshing: $$this.refreshingFlag }) {
        List({ space: 8 }) {
          ForEach(this.listJsonData, (item:ListJsonData, index) => {
            ListItem() {
              Text(`${item.title}`)
                .width('100%')
                .fontSize(20)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .borderRadius(10)
                .backgroundColor(0x007DFF).padding(8)
            }

          }, (item) => JSON.stringify(item))
        }.padding({ top: 10, left: 10, right: 10 })
        .width('98%')
        .onScrollStop(() => {
          if (this.isEnd) {
            this.page += 1
            this.getDataList()
            setTimeout(() => {
              // 加载完数据把滚动条移至底部
              this.scroller.scrollEdge(Edge.Bottom)
            }, 1000)
          }
        }).onScrollStart(() => {
          this.isEnd = false
        }).onReachEnd(() => {
          this.isEnd = true
        })
      }.onRefreshing(() => {
        setTimeout(() => {
          this.page = 0
          this.getDataList()
          this.refreshingFlag = false
        }, 1000)
      }).layoutWeight(1)

    }.width('100%')
    .height('100%').backgroundColor('#ffffff')
  }
}