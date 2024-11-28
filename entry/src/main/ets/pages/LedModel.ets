@Observed
export class ledModel {
  public ledName: string //LED灯名称
  public ledAddress: string //LED灯的节点地址
  public ledState: boolean //LED灯状态
  public isLedExit: boolean //LED灯节点是否存在
  public ledStateCheck: string //检测返回值

  constructor(LedName: string, LedAddress: string, LedState: boolean = false, isLedExit: boolean = true, LedStateCheck: string = '') {
    this.ledName = LedName
    this.ledAddress = LedAddress
    this.ledState = LedState
    this.isLedExit = isLedExit
    this.ledStateCheck = LedStateCheck
  }
}