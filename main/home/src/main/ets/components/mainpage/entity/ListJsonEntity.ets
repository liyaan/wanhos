export class ListJsonEntity{
  curPage:number
  offset:number
  pageCount:number
  size:number
  total:number
  datas:Array<ListJsonData>
}

export class ListJsonData{
  link:string
  title:string
  shareUser:string
  niceDate:string
  niceShareDate:string
  is:number
}