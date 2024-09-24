import { Log } from '@ohos/common/src/main/ets/components/mainpage/log/Log'
import { containerUrl, httpHeaderMap } from '../../../../../..'
import { HttpManager } from '../HttpManager'
import { RequestOptions } from '../RequestOptions'

const TAG = "Decorator testTag"

/**
 * 利用Map保存参数和值的映射关系  为避免参数名及方法名重复 采用组合Key的方法
 */
type FunParamMapKey = {
  target: Object; //所在类
  methodName: string; //所在方法
  index: number; //参数名索引值
}

let funParamMap = new Map<string, string>();
let funParamValueMap = new Map<string, string>();
let funParamFunValueMap = new Map<string, Function>();
type headerFuc = (json: string) => void
type cookieFuc = (json: string) => void

export function GetMethod(url: string): MethodDecorator {
  return function (
      target: Object,
      methodName: string,
      descriptor: PropertyDescriptor
  ) {
    const originalMethod = descriptor.value
    let URL: string = url;
    let options: RequestOptions = {
      url: URL,
      queryParams: {}
    };

    descriptor.value = async function<T>(...args: any[]) {
      Log.log(`${TAG} Method ${methodName} is start with metadata: ${url}  ${JSON.stringify(args)}.`)
      if (args.length > 0) {
        args.forEach((arg, index) => {
          // 通过已知的信息构造组合Key对象
          let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
          let paramName = funParamMap[JSON.stringify(obj)];
          if (typeof paramName !== 'undefined') {
            if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
              options.queryParams[paramName] = arg
            } else {
              console.log('参数类型不对')
              throw new Error(`Invalid parameter type at index ${index}.`);
            }
          }
        });
        //拼接请求参数
        const urlParams = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
        console.log(TAG+'urlParams:', urlParams)
        if (URL.includes("?")) {
          options.url = `${URL}${urlParams}`
        } else {
          options.url = `${URL}?${urlParams}`
        }
      } else {
        options.url = URL
      }
      const result = new Promise<T>((resolve, reject) => {
        HttpManager.getInstance()
          .get<T>(options.url).then((result) => {
          resolve(result)
        }).catch((error) => {
          Log.log(`testTag ${JSON.stringify(error)} `)
          reject(error);
        })
      })
      // Log.log(`${TAG} Method ${propertyKey}  ${JSON.stringify(args)}  ${result} is end.`)
      return await result
    };
  }
}

export function PostJsonMethod(url: string): MethodDecorator {
  return function (
      target: Object,
      methodName: string,
      descriptor: PropertyDescriptor
  ) {
    const originalMethod = descriptor.value;
    let options: RequestOptions = {
      url: url,
      extraData: {}
    };
    descriptor.value = async function<T>(...args: any[]) {
      //对于方法中的每一个（methodName，arg）遍历加入到网络请求配置中
      args.forEach((arg, index) => {
        console.log("参数值", JSON.stringify(arg))
        // 通过已知的信息构造组合Key对象
        let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
        // 通过组合Key（通过对内容的比较而不是值 节省内存）从内存map中获取@Param修饰的内容
        let paramName = funParamMap[JSON.stringify(obj)];
        console.log("参数名：", paramName)
        // 将正确的参数名及值添加至网络请求参数中
        if (typeof paramName !== 'undefined') {
          if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer) {
            options.extraData[paramName] = arg;
          } else {
            throw new Error(`Invalid parameter type at index ${index}.`);
          }
        } else {
          //如果获取不到形参名 及未被@Param标记 并且参数的类型是对象
          if (typeof arg === 'object') {
            options.extraData = JSON.stringify(arg)
          }
        }
      });
      console.log('extraData', JSON.stringify(options.extraData))
      const result = new Promise<T>((resolve, reject) => {
        HttpManager.getInstance()
          .post<T>(options.url,options.extraData,((json)=>{}),((json)=>{})).then((result) => {
          resolve(result)
        }).catch((error) => {
          Log.log(`testTag ${JSON.stringify(error)} `)
          reject(error);
        })
      });
      return await result;
    }
  }
}


export function PostMethod(url: string): MethodDecorator {
  return function (
      target: Object,
      methodName: string,
      descriptor: PropertyDescriptor
  ) {
    const originalMethod = descriptor.value
    let URL: string = url;
    let header:headerFuc
    let cookie:cookieFuc
    let options: RequestOptions = {
      url: URL,
      queryParams: {},
      extraData:""
    };

    descriptor.value = async function<T>(...args: any[]) {
      Log.log(`${TAG} Method ${methodName} is start with metadata: ${url}  ${JSON.stringify(args)}.`)
      if (args.length > 0) {
        args.forEach((arg, index) => {
          // 通过已知的信息构造组合Key对象
          let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
          let paramName
          if (typeof arg === 'function') {
            paramName = funParamFunValueMap[JSON.stringify(obj)];
            console.log('testTag funParamFunValueMap '+paramName)
            if (typeof paramName !== 'undefined') {
              if (paramName === 'header'){
                header = arg
              }else if (paramName === 'cookie'){
                cookie = arg
              }
            }
          }else{
            paramName = funParamMap[JSON.stringify(obj)];
            if (typeof paramName !== 'undefined') {
              if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
                options.queryParams[paramName] = arg
              } else {
                console.log('参数类型不对')
                throw new Error(`Invalid parameter type at index ${index}.`);
              }
            }
          }


        });
        //拼接请求参数
        options.extraData = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
        options.url = URL
        // console.log(TAG+'urlParams:', urlParams)
        // if (URL.includes("?")) {
        //   options.url = `${URL}${urlParams}`
        // } else {
        //   options.url = `${URL}?${urlParams}`
        // }
      } else {
        options.url = url
      }
      const result = new Promise<T>((resolve, reject) => {
        HttpManager.getInstance().setHeader(httpHeaderMap)
          .postFrom<T>(options.url,options.extraData,((value)=>{
            header(value)
          }),((value)=>{
            cookie(value)
          })
          ).then((result) => {
          resolve(result)
        }).catch((error) => {
          Log.log(`testTag ${JSON.stringify(error)} `)
          reject(error);
        })
      })
      // Log.log(`${TAG} Method ${propertyKey}  ${JSON.stringify(args)}  ${result} is end.`)
      return await result
    };
  }
}
function getHeaderAndCookie(obj: FunParamMapKey,header:headerFuc,cookie:cookieFuc,arg:any){

}

export function GetUrlValueMethod(url: string): MethodDecorator {
  return function (
      target: Object,
      methodName: string,
      descriptor: PropertyDescriptor
  ) {
    const originalMethod = descriptor.value
    // let URL: string = url
    let replaceURL = url
    let options: RequestOptions = {
      url: url,
      queryParams: {}
    };

    descriptor.value = async function<T>(...args: any[]) {
      Log.log(`${TAG} Method ${methodName} is start with metadata: ${url}  ${JSON.stringify(args)}.`)
      replaceURL = url
      if (args.length > 0) {
        args.forEach((arg, index) => {
          // 通过已知的信息构造组合Key对象
          let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
          let paramName = funParamMap[JSON.stringify(obj)];
          if (typeof paramName !== 'undefined') {
            if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
              options.queryParams[paramName] = arg
            } else {
              console.log('参数类型不对')
              throw new Error(`Invalid parameter type at index ${index}.`);
            }
          }else{
            // let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
            paramName = funParamValueMap[JSON.stringify(obj)];
            if (typeof paramName !== 'undefined') {
              if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
                console.log(TAG+' paramName:', paramName+"  "+arg+"  "+options.url)
                options.url = replaceURL.replace(paramName,arg)
              } else {
                console.log('参数类型不对')
                throw new Error(`Invalid parameter type at index ${index}.`);
              }
            }
            console.log(TAG+' URL:', options.url)
            replaceURL = options.url
          }
        });
        //拼接请求参数
        const urlParams = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
        console.log(TAG+'urlParams:', urlParams)
        if (url.includes("?")) {
          options.url = `${replaceURL}${urlParams}`
        } else {
          options.url = `${replaceURL}?${urlParams}`
        }
        // replaceURL = options.url
        console.log(TAG+' replaceURL:', options.url)
        // args.forEach((arg, index) => {
        //
        // })
        // options.url = URL
        // args.forEach((arg, index) => {
        //   // 通过已知的信息构造组合Key对象
        //   let obj: FunParamMapKey = { target: target, methodName: methodName, index: index };
        //   let paramName = funParamMap[JSON.stringify(obj)];
        //
        //   if (typeof paramName !== 'undefined') {
        //     if (typeof arg === 'string' || typeof arg === 'object' || arg instanceof ArrayBuffer || typeof arg === 'number') {
        //       options.queryParams[paramName] = arg
        //     } else {
        //       console.log('参数类型不对')
        //       throw new Error(`Invalid parameter type at index ${index}.`);
        //     }
        //   }
        //
        // });
        // //拼接请求参数
        // const urlParams = Object.keys(options.queryParams).map(key => `${key}=${options.queryParams[key]}`).join('&')
        // console.log(TAG+'urlParams:', urlParams)
        // if (urlParams!==null){
        //   if (URL.includes("?")) {
        //     options.url = `${URL}${urlParams}`
        //   } else {
        //     options.url = `${URL}?${urlParams}`
        //   }
        // }else {
        //   options.url = URL
        // }
      } else {
        options.url = url
      }
      const result = new Promise<T>((resolve, reject) => {
        HttpManager.getInstance()
          .get<T>(options.url).then((result) => {
          resolve(result)
        }).catch((error) => {
          Log.log(`testTag ${JSON.stringify(error)} `)
          reject(error);
        })
      })
      // Log.log(`${TAG} Method ${propertyKey}  ${JSON.stringify(args)}  ${result} is end.`)
      return await result
    };
  }
}


/**
 * @Param 注解将想要获取的Param添加至内存Map中
 * @param paramName
 * @returns
 */
export function Param(paramName: string) {
  return function (target: any, methodName: string, parameterIndex: number) {
    let obj: FunParamMapKey = { target: target, methodName: methodName, index: parameterIndex };
    funParamMap[JSON.stringify(obj)] = paramName;
  };
}

/**
 * @Param 注解将想要获取的Param添加至内存Map中
 * @param paramName
 * @returns
 */
export function FunctionParam(paramName: string) {
  return function (target: any, methodName: string, parameterIndex: number) {
    let obj: FunParamMapKey = { target: target, methodName: methodName, index: parameterIndex };
    funParamValueMap[JSON.stringify(obj)] = paramName;
  };
}

/**
 * @Param 注解将想要获取的Param添加至内存Map中
 * @param paramName
 * @returns
 */
export function FunctionFunctionParam(paramName: string) {
  return function (target: any, methodName: string, parameterIndex: number) {
    let obj: FunParamMapKey = { target: target, methodName: methodName, index: parameterIndex };
    funParamFunValueMap[JSON.stringify(obj)] = paramName;
  };
}





