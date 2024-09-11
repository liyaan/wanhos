import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { TreeJsonEntity } from './entity/TreeJsonEntity'
import { TxSecondDialog } from './TxSecondDialog'
@Component
export struct TxHomePage {
  @State message: string = '体系'
  @State entity:TreeJsonEntity[] = []
  @State children:TreeJsonEntity[] = []
  @State title:string = ""
  @State selectIndex:number = 0
  @State dialogTitle:string = ""
  @State cid:number = 0
  dialogController:CustomDialogController = new CustomDialogController(
    {
      builder:TxSecondDialog({cancel:()=>{
        this.dialogController.close()
      },title:this.dialogTitle,cid:this.cid}),
      autoCancel: true,
      customStyle: true
    }
  )
  aboutToAppear() {
    this.getTreeJson()
  }
  private getTreeJson() {
    api.getTreeJson<BaseEntity<Array<TreeJsonEntity>>>().then((result)=>{
      if (this.entity.length > 0) {
        this.entity = []
      }
      this.entity.push(...result.data)
      if (result.data.length>0) {
        this.children = result.data[0].children
        this.title = result.data[0].name
      }

    })
  }
  build() {
    Row() {
      Column() {
        List(){
          ForEach(this.entity,(item:TreeJsonEntity,index)=>{
            ListItem(){
              Column(){
                this.itemText(item,index)
              }.width('100%').height(40).backgroundColor(this.selectIndex == index ? '#999' : '#f7f7f7')
              .justifyContent(FlexAlign.Center)
              .onClick(()=>{
                this.children = []
                this.children = item.children
                this.title = item.name
                this.selectIndex = index
              })
            }
          },item => JSON.stringify(item))
        }
      }.layoutWeight(1)
      .height('100%').backgroundColor('#f7f7f7')
      Column() {
        Text(this.title).textCommon(20).fontWeight(FontWeight.Bold)
        List(){
          ForEach(this.children,(item:TreeJsonEntity)=>{
            ListItem(){
              Column(){
                this.itemText(item,-1)
              }.width('100%').justifyContent(FlexAlign.Center)
            }.onClick(()=>{
              this.dialogTitle = item.name
              this.cid = item.id
              this.dialogController.open()
            })
          },item => JSON.stringify(item))
        }.margin({top:10})
      }.layoutWeight(2)
      .height('100%')
    }
    .height('100%').backgroundColor('#FFFFFF').width('100%')
  }
  @Builder
  itemText(item:TreeJsonEntity,index:number){
    Text(item.name).textCommon(18).fontColor(this.selectIndex == index ? '#fff' : '#000')
  }

}
@Extend(Text)
function textCommon(textSize:number){
  .fontSize(textSize)
  .height(40)
  .align(Alignment.Center)
  .maxLines(1)
  .textOverflow({overflow:TextOverflow.Ellipsis})
}
