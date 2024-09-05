export interface IHttpListener{
  // onSuccess(result:string):void;
  onGetHeaders(header:string):void;
  onGetCookies(cookie:string):void;
  // onFailure(err:string):void;
}