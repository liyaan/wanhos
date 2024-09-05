import HashMap from '@ohos.util.HashMap';

export class MapUtils {
  /**
   * 将HashMap转成JsonString
   * @param map
   * @returns
   */
  static map2Json(map:HashMap<string, object>): string {
    let jsonObject: Record<string, Object> = {};
    map.forEach((value, key) => {
      if(key != undefined && value != undefined){
        jsonObject[key] = value;
      }
    })
    return JSON.stringify(jsonObject);
  }
  static map2Object(map:HashMap<string,object>):object{
    const obj:{[key:string]:object} = {};
    for(const [key,value] of map){
      obj[key.toString()] = value
    }
    return obj
  }
}