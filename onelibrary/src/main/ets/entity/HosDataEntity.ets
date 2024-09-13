export class HosDataEntity{
  links:HosDataList
  open_sources:HosDataList
  tools:HosDataList
}

export class HosDataList{
  name:string
  id:number
  courseId:number
  articleList:ArticleList[]
}
export class ArticleList{
  id:number
  chapterId:number
  courseId:number
  author:string
  chapterName:string
  desc:string
  link:string
  title:string
  superChapterName:string
  niceDate:string
  niceShareDate:string
}

