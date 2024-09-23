import { httpHeaderMap } from './decorator/ContainerMap';
import { IHttpListener } from './IHttpListener';

type headerFuc = (json: string) => void
type cookieFuc = (json: string) => void

export  class AbsHttpRequest implements IHttpListener {
  header:headerFuc
  cookie:cookieFuc

  constructor( header:headerFuc,cookie:cookieFuc) {
    this.header = header
    this.cookie = cookie
  }

  onGetCookies(cookie: string): void {
    if (this.cookie!=null) {
      this.cookie(cookie)
      httpHeaderMap.set("cookie",cookie)
    }

  }

  onGetHeaders(header: string): void {
    if(this.header!=null){
      this.header(header)
      httpHeaderMap.set("header",header)
    }
  }

}