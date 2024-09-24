import { Log } from '@ohos/httpUtils/oh_modules/@ohos/common'

import { api } from './api/Api'
import { BaseEntity } from './entity/BaseEntity'
import { ListJsonData, ListJsonEntity } from './entity/ListJsonEntity'
import { TAG } from './utils/Consts'
import promptAction from '@ohos.promptAction'
import { ShowToast,WBE_PAGE_URL, WebEntity } from '@ohos/libWidght'

import { BannerListEntity } from './entity/BannerListEntity'
import { FriendJson } from './entity/FriendJson'
import { HotkeyJson } from './entity/HotkeyJson'
import { FriendJsonHome } from './FriendJsonHome'
import router from '@ohos.router'


@Component
export struct MainHome {
  @State message: string = '首页'
  @State listData: ListJsonData[] = []
  @State bannerList: BannerListEntity[] = []
  @State friendJson: FriendJson[] = []
  @State hotkeyJson: HotkeyJson[] = []
  @State
  private refreshingFlag: boolean = false;
  // 判断滚动条是否触底
  @State
  private isEnd: boolean = false;
  // 使用Scroller对象
  private scroller: Scroller = new Scroller();
  @State
  private page: number = 0
  private swiperController: SwiperController = new SwiperController()

  dialogController:CustomDialogController = new CustomDialogController(
    {
      builder:FriendJsonHome({cancel:()=>{
        this.dialogController.close()
      }}),
      autoCancel: true,
      customStyle: true
    }
  )

  @Builder
  private LoadingCustom() {
    Stack() {
      Row() {
        // Loading 组件
        LoadingProgress().width(30).color("#4095cb")
      }
    }.width('100%')
  }

  aboutToAppear() {

    this.getBannerList()

    this.getHotkeyJson()
  }

  private getBannerList() {
    api.getBanner<BaseEntity<Array<BannerListEntity>>>().then((result) => {
      if (this.bannerList.length > 0) {
        this.bannerList = []
      }
      this.bannerList.push(...result.data)

      this.getFriendJson()
    })
  }

  private getDataList() {
    api.listJson<BaseEntity<ListJsonEntity>>(this.page).then((result) => {
      if (this.page === 0) {
        if (this.listData.length > 0) {
          this.listData = []
        }
      }
      Log.log(TAG + "  " + result.data.datas[0].title)
      this.listData.push(...result.data.datas)
    })
  }

  private getFriendJson() {
    api.getFriendJson<BaseEntity<Array<FriendJson>>>().then((result) => {
      if (this.friendJson.length > 0) {
        this.friendJson = []
      }
      if (result.data.length > 4) {
        this.friendJson.push(...result.data.slice(0, 4))
      } else {
        this.friendJson.push(...result.data)
      }
      this.getDataList()
      Log.info("getFriendJson = " + this.friendJson.length)
    })
  }

  private getHotkeyJson() {
    api.getHotkeyJson<BaseEntity<Array<HotkeyJson>>>().then((result) => {
      if (this.friendJson.length > 0) {
        this.friendJson = []
      }
      this.hotkeyJson.push(...result.data)
    })
  }

  build() {
    Row() {
      Column() {
        Row() {
          if (this.hotkeyJson.length > 0) {
            Swiper(this.swiperController) {
              ForEach(this.hotkeyJson, (item: HotkeyJson, index) => {
                Row() {
                  Text(item.name)
                    .fontColor('#808080')
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .height(45)
                    .width('80%')
                    .margin({ left: 25 })
                  Text("搜索")
                    .fontSize(18)
                    .fontColor("#909090")
                    .width(70)
                    .height(45)
                    .align(Alignment.Center)
                    .margin({ right: 25 })
                    .onClick(() => {
                      ShowToast.show(item.name + " 搜索功能开发中")
                    })
                }.width('100%')
                .height(50)
                .borderRadius(25)
              }, (item) => JSON.stringify(item))
            }
            .loop(true)
            .autoPlay(true)
            .interval(2000)
            .width('100%')
            .height(50)
            .vertical(true)
            .indicator(false)
          }
        }
        .width('95%')
        .height(50)
        .borderRadius(25)
        .backgroundColor("#ccc")
        .margin({ top: 15 })

        Refresh({ refreshing: $$this.refreshingFlag }) {

          List({ space: 8 }) {

            ListItem() {
              if (this.bannerList.length > 0) {
                Swiper(this.swiperController) {
                  ForEach(this.bannerList, (item: BannerListEntity, index) => {
                    Image(item.imagePath).height(200).width('95%').objectFit(ImageFit.Contain).borderRadius(20)
                      .onClick(()=>{
                        let paramsInfo:WebEntity = {
                          url:item.url,
                          title:item.title
                        }
                        router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo})
                      })
                  }, (item) => JSON.stringify(item))
                }
                .loop(true)
                .autoPlay(true)
                .interval(2000)
                .width('100%')
                .height(200)
              }
            }

            ListItem() {
              Column() {
                Text("常用网站")
                  .width('100%')
                  .height(40)
                  .fontSize(18)
                  .padding({ left: 20 })
                  .fontWeight(FontWeight.Bold)
                  .backgroundColor("#f7f7f7")
                  .onClick(() => {
                    this.dialogController.open()
                  })
                GridRow({ columns: 2 }) {
                  ForEach(this.friendJson, (item: FriendJson, index) => {
                    GridCol() {
                      Column() {
                        Image("https://qna.smzdm.com/202409/08/66dd399098a88773.jpg_e680.jpg")
                          .width('100%').height(90).objectFit(ImageFit.Fill).borderRadius(8)
                        Text(item.name)
                          .fontSize(16)
                          .align(Alignment.Bottom)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })
                      }.height(110).width('100%')
                      .onClick(()=>{
                        let paramsInfo:WebEntity = {
                          url:item.link,
                          title:item.name
                        }
                        router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo})
                      })
                    }.margin({ left: 5, right: 5 })
                  }, (item) => JSON.stringify(item))
                }.margin({ top: 5, bottom: 5 })
                .width('95%')
              }
              .width('100%')
            }

            ForEach(this.listData, (item: ListJsonData, index) => {
              ListItem() {
                Text(`${item.title}`)
                  .width('100%')
                  .height(100)
                  .fontSize(20)
                  .fontColor(Color.White)
                  .textAlign(TextAlign.Center)
                  .borderRadius(10)
                  .backgroundColor(0x007DFF)
              }.onClick(()=>{
                let paramsInfo:WebEntity = {
                  url:item.link,
                  title:item.title
                }
                router.pushUrl({url:WBE_PAGE_URL,params:paramsInfo})
              })
            }, item => item)
          }.padding({ top: 10, left: 10, right: 10 })
          .onScrollStop(() => {
            if (this.isEnd) {
              // 加载数据
              promptAction.showToast({ message: '加载数据' })
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
        } // 进入刷新状态时触发回调。这里两后停止刷新状态
        .onRefreshing(() => {
          setTimeout(() => {
            this.page = 0
            this.getDataList()
            this.refreshingFlag = false
          }, 2000)
        }).layoutWeight(1)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }.width('100%')
    .height('100%').backgroundColor('#FFFFFF')
  }
}

