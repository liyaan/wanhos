import { PreferencesUtils } from './src/main/ets/components/mainpage/PreferencesUtils'

export { MainPage } from './src/main/ets/components/mainpage/MainPage'
export { HttpManager } from './src/main/ets/components/mainpage/HttpManager'
export { AbsHttpRequest } from './src/main/ets/components/mainpage/AbsHttpRequest'
export { Constants }  from './src/main/ets/components/mainpage/utils/Constants'
export { MapToJson }  from './src/main/ets/components/mainpage/utils/MapToJson'
import { ContainerUrl }  from './src/main/ets/components/mainpage/decorator/ContainerUrl'
export { httpHeaderMap }  from './src/main/ets/components/mainpage/decorator/ContainerMap'
export { GetMethod ,Param,PostMethod,PostJsonMethod,FunctionParam,GetUrlValueMethod,FunctionFunctionParam} from './src/main/ets/components/mainpage/decorator/DecoratorFunction'

// export default PreferencesUtils
export const preferenceUtil = new PreferencesUtils()
export const containerUrl = new ContainerUrl()

  // PreferencesUtils as preferenceUtil
// export const  constants = new Constants()
