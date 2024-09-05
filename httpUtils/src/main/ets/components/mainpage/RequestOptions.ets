export interface RequestOptions {
  url?: string;
  method?: RequestMethod; // default is GET
  queryParams ?: Record<string, string>;
  extraData?: string | Object | ArrayBuffer;
  header?:  Object ;
  connectTimeout?:number;
  readTimeout?: number;

}

export enum RequestMethod {
  OPTIONS = "OPTIONS",
  GET = "GET",
  HEAD = "HEAD",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE",
  TRACE = "TRACE",
  CONNECT = "CONNECT"
}

declare const mRequestOptions: RequestOptions;