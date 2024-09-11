export class NaviJsonEntity{
  cid:number
  name:string
  articles:NaviJsonData[]
}

export class NaviJsonData{
  id:number
  chapterId:number
  courseId:number
  author:string
  chapterName:string
  link:string
  title:string
  niceDate:string
  niceShareDate:string
}