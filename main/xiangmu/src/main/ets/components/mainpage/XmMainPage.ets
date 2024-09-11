import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { ProjectJsonData, ProjectJsonList, ProjectTreeJsonEntity } from './entity/ProjectTreeJsonEntity'
import { ShowToast } from '@ohos/libWidght'
import { Log } from '../../../../../../../httpUtils/oh_modules/@ohos/common/src/main/ets/components/mainpage/log/Log'
import { XmInfoDialog } from './XmInfoDialog'

@Component
export struct XmMainPage {
  @State projectEntity: ProjectTreeJsonEntity[] = []
  @State projectList: ProjectJsonData[] = []

  private controller: TabsController = new TabsController()
  @State currentIndex: number = 0
  @State
  private refreshingFlag: boolean = false;
  @State
  private page: number = 1
  // 判断滚动条是否触底
  @State
  private isEnd: boolean = false;
  // 使用Scroller对象
  private scroller: Scroller = new Scroller();
  @State projectListBean: ProjectJsonData = null
  dialogController:CustomDialogController = new CustomDialogController(
    {
      builder:XmInfoDialog({cancel:()=>{
        this.dialogController.close()
      },projectJsonData:this.projectListBean}),
      autoCancel: true,
      customStyle: true
    }
  )

  aboutToAppear() {
    this.getProjectJson()
  }

  getProjectJson() {
    api.getProjectJson<BaseEntity<Array<ProjectTreeJsonEntity>>>().then((result) => {
      this.projectEntity = result.data
      if (result.data.length > 0) {
        this.getProjectList()
      }

    })
  }

  getProjectList() {
    Log.info("testTag aaaaaaaaaaaaaaaaaaaaaaaaaa")
    api.getProjectList<BaseEntity<ProjectJsonList>>(this.page,
      this.projectEntity[this.currentIndex].id).then((result) => {
      if (this.page === 1) {
        if (this.projectList.length > 0) {
          this.projectList = []
        }
      }
      if (result.data.pageCount > this.page) {
        this.projectList.push(...result.data.datas)
      } else {
        ShowToast.show("暂无更多数据")
      }
    })
  }

  build() {
    Row() {
      Tabs({ barPosition: BarPosition.Start ,controller: this.controller,index:this.currentIndex}) {
        ForEach(this.projectEntity, (item: ProjectTreeJsonEntity, index) => {
          TabContent() {
            this.listBuilder(index)
          }.tabBar(item.name)
        })
      }
      .vertical(true)
      .barMode(BarMode.Scrollable)
      .scrollable(false)
      .barWidth(100)
      .barHeight('100%')
      .backgroundColor('#f7f7f7')
      .onChange((index)=>{
        this.page = 1
        this.currentIndex = index
        this.getProjectList()
      })
    }.width('100%')
    .height('100%')
  }

  @Builder
  listBuilder(index:number) {
    Refresh({ refreshing: $$this.refreshingFlag }) {
      List({ space: 10 }) {
        ForEach(this.projectList, (item: ProjectJsonData, index) => {
          ListItem() {
            Column() {
              Image(item.envelopePic).width('95%').borderRadius(10)
              Text(item.title).maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
                .fontSize(16).fontWeight(FontWeight.Bold).margin({top:10,bottom:10})
            }.width('100%').backgroundColor('#fff').borderRadius(10)
          }.onClick(()=>{
            this.projectListBean = item
            this.dialogController.open()
          })
        }, (item) => JSON.stringify(item))
      }.onScrollStop(() => {
        if (this.isEnd) {
          this.page += 1
          this.getProjectList()
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
        this.getProjectList()
        this.refreshingFlag = false
      }, 1000)
    })

  }
}
