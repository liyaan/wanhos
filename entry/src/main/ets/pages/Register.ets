import hilog from '@ohos.hilog';
import router from '@ohos.router';
import { HttpManager } from '@ohos/httpUtils';
import { BaseEntity } from '../entity/BaseEntity';
import { LoginEntity } from '../entity/LoginEntity';
import { ShowToastUtils } from '@ohos/httpUtils/oh_modules/@ohos/common';


@Entry
@Component
struct Register {
  @State message: string = '用户注册'
  @State loginPhone: string = ''
  @State loginPassWord: string = ''
  @State loginRePassWord: string = ''
  @State colorBtnBg: string = '#46CDD0'
  @State colorBorderBg:string = '#DECECE'
  @State enabledBtn:boolean = false

  build() {
    Row() {
      Column({space:30}) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        TextInput({ placeholder: "请输入帐号" , text:"13131141157"})
          .fontColor(Color.Black).fontSize(20)
          .type(InputType.PhoneNumber)
          .height(45).onChange((val)=>{
          this.loginPhone = val
          if (this.loginPhone.length==11 && this.loginPassWord.length>6 && this.loginPassWord.length<=16
          && this.loginRePassWord.length>6 && this.loginRePassWord.length<=16) {
            this.enabledBtn = true;
          }else{
            this.enabledBtn = false;
          }
        }).maxLength(11)
        TextInput({ placeholder: "请输入密码",text:"1234567" })
          .fontColor(Color.Black).fontSize(20)
          .type(InputType.Password)
          .maxLength(16)
          .height(45).onChange((val)=>{
          this.loginPassWord = val
          if (this.loginPhone.length==11 && this.loginPassWord.length>6 && this.loginPassWord.length<=16
          && this.loginRePassWord.length>6 && this.loginRePassWord.length<=16) {
            this.enabledBtn = true;
          }else{
            this.enabledBtn = false;
          }

        })
        TextInput({ placeholder: "请确认输入密码",text:"1234567" })
          .fontColor(Color.Black).fontSize(20)
          .type(InputType.Password)
          .maxLength(16)
          .height(45).onChange((val)=>{
          this.loginRePassWord = val
          if (this.loginPhone.length==11 && this.loginPassWord.length>6 && this.loginPassWord.length<=16
              && this.loginRePassWord.length>6 && this.loginRePassWord.length<=16) {
            this.enabledBtn = true;
          }else{
            this.enabledBtn = false;
          }

        })
        Button('注 册').height(45).width('100%').backgroundColor(this.colorBtnBg).borderRadius(20).onClick(()=>{
          hilog.info(0x0000, 'testTag', 'loginPhone=%{public}s', this.loginPhone);
          hilog.info(0x0000, 'testTag', 'loginPassWord=%{public}s', this.loginPassWord);
          let map ="username="+this.loginPhone+"&password="+this.loginPassWord+"&repassword="+this.loginRePassWord
          HttpManager
            .getInstance().postFrom<BaseEntity<LoginEntity>>(
            "https://www.wanandroid.com/user/register",map
          ).then((result)=>{
            hilog.info(0x0000, 'testTag', 'result=%{public}s', result.errorMsg);
            if(result.errorCode==0){
              router.back()
            }else{
              ShowToastUtils.show(result.errorMsg)

            }
          }).catch((error)=>{
            hilog.info(0x0000, 'testTag', 'error=%{public}s',JSON.stringify(error));
          })

        }).onHover((isHover)=>{
          if (isHover) {
            if(isHover){
              this.colorBtnBg = '#46CDD0'
            }else {
              this.colorBtnBg ='#3E84A6'
            }
          }
        }).enabled(this.enabledBtn)

      }
      .width('90%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}
