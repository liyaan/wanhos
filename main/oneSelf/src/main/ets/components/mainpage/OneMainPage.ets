import { preferenceUtil, Constants } from '@ohos/httpUtils'
import router from '@ohos.router'
import { SCROLLDHJB,LISTHEADER, LISTTABHEADER } from "@ohos/onelibrary"
import { AlertBottomDialog } from './AlertBottomDialog'
import { AlertPromptDialog } from './AlertPromptDialog'
import { SelectDatePickerDialog } from './SelectDatePickerDialog'
import { ARKTSBASE, ARKTSBASELIST, LISTTABSCROLLHEADER } from '@ohos/onelibrary/src/main/ets/utils/RouterUtils'

@Component
export struct OneMainPage {
  @State userName: string = ""
  @State passWord: string = ""
  scroller: Scroller = new Scroller()
  dialogController:CustomDialogController = new CustomDialogController({
    builder:AlertBottomDialog(
      {
        contents:['选项1','选项2','选项3','选项4'],
        close:()=>{
          this.dialogController.close()
        },
        itemClick:(index)=>{
          console.log("index = "+index)
        }
      }
    ),
    alignment:DialogAlignment.Bottom
  })

  dialogPromptController:CustomDialogController = new CustomDialogController({
    builder:AlertPromptDialog(
      {
        contents:"提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语提示语",
        close:()=>{
          this.dialogPromptController.close()
        },
        submit:()=>{
          this.dialogPromptController.close()
          console.log("index = 提示语")
        }
      }
    ),
    alignment:DialogAlignment.Center
  })

  dialogSelectData:CustomDialogController = new CustomDialogController({
    builder:SelectDatePickerDialog(
      {
        close:()=>{
          this.dialogSelectData.close()
        },
        selectData:(value)=>{
          this.dialogSelectData.close()
          console.log("index = "+value)
        }
      }
    ),
    alignment:DialogAlignment.Bottom
  })
  aboutToAppear() {
    preferenceUtil.get(Constants.USERNAME).then((result) => {
      this.userName = result.toString()
    })
  }

  build() {
    Column() {
      Row() {
        Image('https://k.sinaimg.cn/n/sinakd20117/0/w800h800/20240127/889b-4c8a7876ebe98e4d619cdaf43fceea7c.jpg/w700d1q75cms.jpg')
          .width(50)
          .height(50)
          .borderRadius(25)
          .borderWidth(1)
          .borderColor('#ccc')
          .margin({ right: 10 })
        Text(this.userName).fontSize(20).fontWeight(FontWeight.Bold)
      }.width('100%').padding({ left: 15, right: 15 }).height(100).backgroundColor('#FfFfFf')

      Scroll(this.scroller) {
        Column() {
          this.linearWidget('Scroll组件结合属性动画实现导航背景色切换效果', SCROLLDHJB)
          this.linearWidget('List滚动吸顶', LISTHEADER)
          this.linearWidget('自定义底部弹框','1')
          this.linearWidget('自定义提示弹框','2')
          this.linearWidget('自定义弹框选择时间','3')
          this.linearWidget('Tab滚动置顶',LISTTABHEADER)
          this.linearWidget('Tab_Scroll滚动置顶',LISTTABSCROLLHEADER)
          this.linearWidget('ArkTS基础',ARKTSBASE)
          this.linearWidget('ArkTS基础-LIST',ARKTSBASELIST)
        }
      }

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  linearWidget(title: string, routerUrl?: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 15, right: 15 })
        .onClick(() => {
          if (routerUrl) {
            if (routerUrl==='1') {
              this.dialogController.open()
            }else if (routerUrl==='2'){
              this.dialogPromptController.open()
            }else if (routerUrl==='3'){
              this.dialogSelectData.open()
            }else{
              router.pushUrl({ url: routerUrl })
            }

          }
        })
    }.width('100%').height(50).margin({ top: 10 }).backgroundColor(Color.White)
  }


}
