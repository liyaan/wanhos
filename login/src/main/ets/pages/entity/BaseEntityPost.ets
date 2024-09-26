export class BaseEntityPost{
  page:number
  size:number
  key:string

  constructor(key:string, size:number,page:number) {
    this.page = page
    this.size = size
    this.key = key
  }
}



