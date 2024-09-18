import { api } from '../api/Api'
import { BaseEntity } from '../entity/BaseEntity'
import { ArticleList, HosDataEntity, HosDataList } from '../entity/HosDataEntity'
@Entry
@Component
struct ListHeader {
  @State dataEntity:HosDataList[] =[]

  aboutToAppear(){
    api.getHotkeyJson<BaseEntity<HosDataEntity>>()
      .then((result)=>{
        this.dataEntity.push(result.data.links)
        this.dataEntity.push(result.data.open_sources)
        this.dataEntity.push(result.data.tools)
    })
  }
  //悬停View
  @Builder
  CustomHeader(content:string) {
    Text(content)
      .height(60)
      .backgroundColor(Color.Gray)
      .width('100%')
  }
  build() {
    List({space: 10}) {
      ForEach(this.dataEntity,(item:HosDataList)=>{
        ListItemGroup({
          header: this.CustomHeader(item.name),
          space: 10
        }) {
          ForEach(item.articleList, (item: ArticleList, index: number) => {
            ListItem() {
              Text(item.title)
                .height(60)
                .backgroundColor('#f00')
                .width('100%')
                .align(Alignment.Center)
            }
          })
        }
      })
    }
      .width('100%')
      .height('100%')
      .sticky(StickyStyle.Header)
  }
}