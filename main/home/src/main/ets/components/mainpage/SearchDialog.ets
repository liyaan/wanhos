
import { TitlePage, WBE_PAGE_URL, WebEntity } from '@ohos/libWidght'
import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { HotkeyJson } from './entity/HotkeyJson'
import { ListJsonSearchData, ListJsonSearchEntity } from './entity/ListJsonEntity'
import router from '@ohos.router'
import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common'
@CustomDialog
@Component
export struct SearchDialog{
  cancel: () => void = ()=>{
    console.info('Callback when the second button is clicked')
  }
  confirm: () => void = () => {
    console.info('Callback when the second button is clicked')
  }
  controller: CustomDialogController = new CustomDialogController({
    builder: SearchDialog({
      cancel: this.cancel,
      confirm: this.confirm,
    }),
    autoCancel: true,
    customStyle: true,

  })
  @State inputContent:string = ''
  @State hotkeyJson: HotkeyJson[] = []
  @State listData: ListJsonSearchData[] = []
  aboutToAppear() {
    this.getHotkeyJson()
  }
  private getHotkeyJson() {
    api.getHotkeyJson<BaseEntity<Array<HotkeyJson>>>().then((result) => {
      this.hotkeyJson.push(...result.data)
    })
  }
  private getQueryJson(k:string) {
    api.getQueryJson<BaseEntity<ListJsonSearchEntity>>(k).then((result) => {
      if (this.listData.length>0) {
        this.listData = []
      }
      this.listData.push(...result.data.datas)
    })
  }
  build(){
    Column(){
      TitlePage({title:"搜索",back:this.cancel})
      Row(){
        TextInput({placeholder:'请输入搜索内容'}).layoutWeight(1)
          .height(40)
          .fontColor(Color.Black)
          .fontSize(20)
          .borderRadius(20)
          .margin({left:5,right:5})
          .backgroundColor(Color.Transparent)
          .onChange((value)=>{
            this.inputContent = value
          })
        Button('搜索').width(100).height(40).borderRadius(20).fontColor(Color.White)
          .fontSize(20).backgroundColor(Color.Orange).margin({right:5})
          .onClick(()=>{
            if (this.inputContent) {
              this.getQueryJson(this.inputContent)
            }
          })
      }
      .width('95%')
      .height(50)
      .borderRadius(25)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#f0f0f0')

      Column(){
        Text('搜索热词').fontSize(20).fontStyle(FontStyle.Normal).fontWeight(FontWeight.Bold)
         .margin({left:10,top:10})
        Flex({wrap:FlexWrap.Wrap}){
          ForEach(this.hotkeyJson,(item:HotkeyJson, index) => {
            Text(item.name).padding({left:10,right:10,top:5,bottom:5})
              .fontSize(15)
              .fontColor(Color.White)
              .backgroundColor(Color.Gray)
              .borderRadius(5).margin(10)
              .onClick(()=>{
                this.getQueryJson(item.name)
              })
          },(item) => JSON.stringify(item))
        }.width('100%')
      }.width('100%').justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)

      Grid() {
        ForEach(this.listData, (item: ListJsonSearchData, index) => {
          GridItem() {
            Column() {
              Text(item.title)
                .fontSize(16)
                .align(Alignment.Bottom)
                .maxLines(4)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }.height(110).width('100%')
            .onClick(()=>{
              let paramsInfo:WebEntity = {
                url:item.link,
                title:item.title
              }
              router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo}).then((res)=>{
                Log.info("testTag then"+JSON.stringify(res))
                this.cancel()
              }).catch((error)=>{
                Log.info("testTag catch "+JSON.stringify(error))
                this.cancel()
              })
            })
          }.margin({ left: 5, right: 5 })
        }, (item) => JSON.stringify(item))
      }.columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('95%')
      .layoutWeight(1)

      // List({ space: 8 }){
      //   ForEach(this.listData,(item:ListJsonSearchData,index)=>{
      //     ListItem(){
      //       Text(item.title).fontSize(18).fontColor(Color.Black).padding(10)
      //     }
      //   },(item) => JSON.stringify(item))
      // }.width('100%')
      // .layoutWeight(1)
    }.width('100%').backgroundColor('#ffffff').height('100%')
  }
}