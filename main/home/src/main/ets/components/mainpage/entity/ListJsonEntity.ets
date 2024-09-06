import ArrayList from '@ohos.util.ArrayList'
export class ListJsonEntity{
  curPage:number
  offset:number
  pageCount:number
  size:number
  total:number
  datas:ListJsonData[]
}

export class ListJsonData{
  link:string
  title:string
  shareUser:string
  niceDate:string
  niceShareDate:string
  is:number
}