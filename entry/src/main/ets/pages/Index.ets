import hilog from '@ohos.hilog';
import testNapi from 'libentry.so'
import router from '@ohos.router';
import { Utils } from '../utils/Utils';

@Entry
@Component
struct Index {
  @State message: string = '欢迎使用'
  @State rotateAngle: number = 0
  aboutToAppear(){
    setTimeout(()=>{
      Utils.getMainLayout()
    },1000)
    animateTo({
      duration: 1000,
      curve: Curve.Friction,
      delay: 500,
      iterations: -1, // 设置-1表示动画无限循环
      playMode: PlayMode.AlternateReverse,
      onFinish: () => {
        Utils.getMainLayout()
      }
    },()=>{
      this.rotateAngle = 90
    })
  }
  build() {
    Row() {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .rotate({ angle: this.rotateAngle })
        .onClick(() => {
          hilog.info(0x0000, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3));
        }).transition({ type: TransitionType.Insert, scale: { x: 0, y: 1.0 } })
          .transition({ type: TransitionType.Delete, rotate: { angle: 180 } })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }


}
