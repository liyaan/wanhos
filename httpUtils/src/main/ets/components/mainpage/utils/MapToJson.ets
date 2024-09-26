import HashMap from '@ohos.util.HashMap';
export class MapToJson{

  static mapToJson(map:Map<string,any>){
    let jsonObject: Record<string, any> = {};
    map.forEach((value, key) => {
      if (key !== undefined && value !== undefined) {
        jsonObject[key] = value;
      }
    })
    return jsonObject
  }
  static hashMapToJson(map:HashMap<string,any>){
    let jsonObject: Record<string, any> = {};
    map.forEach((value, key) => {
      if (key !== undefined && value !== undefined) {
        jsonObject[key] = value;
      }
    })
    return jsonObject
  }
}