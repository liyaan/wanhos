export class ArticleItem {
  id: number;
  title: string;
  img: ResourceStr;
  author: string;
  date: string;

  constructor(id: number, title: string, img: ResourceStr, author: string, date: string) {
    this.id = id
    this.title = title
    this.img = img
    this.author = author
    this.date = date
  }
}