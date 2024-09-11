export class TreeJsonList{
  curPage:number
  offset:number
  pageCount:number
  size:number
  total:number
  datas:ListJsonData[]
}
export class ListJsonData{
  chapterName:string
  chapterId:number
  courseId:number
  id:number
  link:string
  niceDate:string
  niceShareDate:string
  shareUser:string
  superChapterName:string
  superChapterId:number
  title:string
}
/**
 *
 * {
 "adminAdd": false,
 "apkLink": "",
 "audit": 1,
 "author": "",
 "canEdit": false,
 "chapterId": 60,
 "chapterName": "Android Studio相关",
 "collect": false,
 "courseId": 13,
 "desc": "",
 "descMd": "",
 "envelopePic": "",
 "fresh": false,
 "host": "",
 "id": 12871,
 "isAdminAdd": false,
 "link": "https://juejin.im/post/5e94815551882573af79b2a0",
 "niceDate": "2020-04-14 00:05",
 "niceShareDate": "2020-04-13 23:58",
 "origin": "",
 "prefix": "",
 "projectLink": "",
 "publishTime": 1586793921000,
 "realSuperChapterId": 150,
 "selfVisible": 0,
 "shareDate": 1586793515000,
 "shareUser": "鸿洋",
 "superChapterId": 60,
 "superChapterName": "开发环境",
 "tags": [

 ],
 "title": "数据库还可以这么看？（Android Studio 4.1 新特性）",
 "type": 0,
 "userId": 2,
 "visible": 1,
 "zan": 0
 }*/