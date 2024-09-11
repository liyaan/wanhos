export class ProjectTreeJsonEntity{
  id:number
  courseId:number
  parentChapterId:number
  name:string
}


export class ProjectJsonList{
  curPage:number
  offset:number
  pageCount:number
  size:number
  total:number
  datas:ProjectJsonData[]
}
export class ProjectJsonData{
  chapterId:number
  chapterName:string
  desc:string
  author:string
  courseId:number
  superChapterId:number
  envelopePic:string
  link:string
  niceDate:string
  niceShareDate:string
  projectLink:string
  superChapterName:string
  title:string
}