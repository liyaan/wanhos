import hilog from '@ohos.hilog';
import testNapi from 'libentry.so'
import { Utils } from '@ohos/login';
import { ledModel } from './LedModel';
import promptAction from '@ohos.promptAction';
import { EncryptionUtils } from '../../../../../httpUtils/oh_modules/@ohos/common';


@Entry
@Component
struct Index {
  @State msg: string = '欢迎使用'
  @State rotateAngle: number = 0
  @State message: number = 0;
  @State led: ledModel = new ledModel('LED_Green',
    '/sys/class/leds/pilot_lamp/brightness') //开发板控制LED灯节点地址'/sys/class/leds/pilot_lamp/brightness'
  private setIntervalID: number = -1

  async ledCheck() {
    this.led.ledStateCheck = await testNapi.bq_GPIO_State(this.led.ledAddress);
    if (this.led.ledStateCheck === '1') {
      this.led.ledState = true;
    } else if (this.led.ledStateCheck === 'Error: the GPIO is not exist') {
      this.led.isLedExit = false
    } else {
      this.led.ledState = false
    }
  }

  async aboutToAppear() {
    await this.ledCheck();
    this.setIntervalID = setInterval(async () => {
      await this.ledCheck()
    }, 500)
    // setTimeout(()=>{
    //   Utils.getMainLayout()
    // },1000)
    animateTo({
      duration: 1000,
      curve: Curve.Friction,
      delay: 500,
      iterations: -1, // 设置-1表示动画无限循环
      playMode: PlayMode.AlternateReverse,
      onFinish: () => {
        Utils.getMainLayout()
      }
    }, () => {
      this.rotateAngle = 90
    })
  }

  build() {
    Column() {
      Text("点亮一个LED灯")
        .size({ width: '100%', height: 35 })
        .margin({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
        .fontSize(30)
        .fontWeight(800)
      Column({ space: 10 }) {
        ledList({ item: this.led })
      }
      .margin({ top: 20, bottom: 10 })
      .size({ width: '50%', height: 50 })
      .justifyContent(FlexAlign.Start)
      .alignSelf(ItemAlign.Center)

      Row() {
        Text(this.msg)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .rotate({ angle: this.rotateAngle })
          .onClick(() => {
            hilog.info(0x0000, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3));
            hilog.info(0x0000, 'testTag', 'Test NAPI 3 - 2 = %{public}d', testNapi.minus(3, 2));
            hilog.info(0x0000, 'testTag', 'Test NAPI 3 * 2 = %{public}d', testNapi.multiply(3, 2));
            hilog.info(0x0000, 'testTag', 'Test NAPI 4 / 2 = %{public}d', testNapi.division(4, 2));
            testNapi.getMd5("aaaaaaa").then((res)=>{
              hilog.info(0x0000, 'testTag', 'getMd5 = %{public}s', res);
              const data = EncryptionUtils.base64Encode(res)
              hilog.info(0x0000, 'testTag', 'base64Encode = %{public}s', data);
              const dataDecode = EncryptionUtils.base64Decode(data)
              hilog.info(0x0000, 'testTag', 'base64Decode = %{public}s', dataDecode);
            })
            testNapi.addAsync(1,2,(result)=>{
              hilog.info(0x0000, 'testTag', 'addAsync = %{public}d', result);
            })

            Utils.getMainLayout()
          })
          .transition({ type: TransitionType.Insert, scale: { x: 1.0, y: 0 } })
          .transition({ type: TransitionType.Delete, rotate: { angle: 180 } })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .size({ width: '100%', height: '100%' })

  }

  aboutToDisappear() {
    clearInterval(this.setIntervalID)
  }
}

@Component
struct ledList {
  @ObjectLink item: ledModel

  tip(str: string) {
    let show: string
    switch (str) {
      case "1":
        show = '已打开';
        break;
      case "0":
        show = '已关闭';
        break;
      default:
        show = `error: ${str}`
    }
    promptAction.showToast({
      message: show,
      duration: 800
    })
  }

  build() {
    Row() {
      Text(`${this.item.ledName}`)
        .size({ width: '70%', height: 35 })
        .fontSize(30)
        .fontWeight(700)
        .fontColor(this.item.isLedExit === true ? Color.Black : '#c9c9cd')
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.item.ledState })
        .size({ width: 80, height: 35 })
        .enabled(this.item.isLedExit)
        .onChange(async (isOn) => {
          if (isOn) {
            let res: string = await testNapi.bq_GPIO_On(this.item.ledAddress)
            this.tip(res)
          } else {
            let res: string = await testNapi.bq_GPIO_Off(this.item.ledAddress)
            this.tip(res)
          }
        })
    }.width('100%')
  }
}
