
export class ContainerUrl{
  private url:string
  private cookieFuc:(json: string) => void
  private headerFuc:(json: string) => void

  settingUrl(url:string):ContainerUrl{
    this.url = url
    return this
  }

  settingCookie(cookieFuc:(json: string) => void):ContainerUrl{
    this.cookieFuc = cookieFuc
    return this
  }
  settingHeaderFuc(headerFuc:(json: string) => void):ContainerUrl{
    this.headerFuc = headerFuc
    return this
  }
  getCookie(){
    return this.cookieFuc
  }
  getHeaderFuc(){
    return  this.headerFuc
  }
}