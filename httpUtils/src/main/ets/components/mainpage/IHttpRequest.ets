import { IHttpListener } from './IHttpListener';
import { RequestOptions } from './RequestOptions';
export interface IHttpRequest{
  setUrl(url:string):void;

  execute<T>(requestOption: RequestOptions):Promise<T>;

  setListener(iHttpListener:IHttpListener):void;
}