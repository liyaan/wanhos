import { Constants } from './Constants';
export  class GlobalContext {
  private constructor() { }
  private static instance: GlobalContext;
  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(value: string): Object | undefined {
    return Constants.OBJECT_MAP.get(value);
  }

  setObject(key: string, objectClass: Object): void {
    Constants.OBJECT_MAP.set(key, objectClass);
  }


}