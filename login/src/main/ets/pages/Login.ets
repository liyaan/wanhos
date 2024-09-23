import hilog from '@ohos.hilog';
import router from '@ohos.router';
import  {Param, PostMethod, preferenceUtil,Constants, httpHeaderMap, FunctionFunctionParam} from '@ohos/httpUtils'

import { Log, ShowToastUtils } from '@ohos/httpUtils/oh_modules/@ohos/common';
import { Utils } from './utils/Utils';
import { BaseEntity } from './entity/BaseEntity';
import { LoginEntity } from './entity/LoginEntity';
import { REGISTER } from './utils/RouterUtils';

@Entry
@Component
export struct Login {
  @State message: string = '用户登录'
  @State loginPhone: string = ''
  @State loginPassWord: string = ''
  @State colorBtnBg: string = '#46CDD0'
  @State colorBorderBg:string = '#DECECE'
  @State enabledBtn:boolean = false

  build() {
    Row() {
      Column({space:30}) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        TextInput({ placeholder: "请输入帐号" ,text:"13131141157"})
          .fontColor(Color.Black).fontSize(20)
          .type(InputType.PhoneNumber)
          .height(45).onChange((val)=>{
          this.loginPhone = val
          if (this.loginPhone.length==11 && this.loginPassWord.length>6 && this.loginPassWord.length<18) {
            this.enabledBtn = true;
          }else{
            this.enabledBtn = false;
          }
        }).maxLength(11)
        TextInput({ placeholder: "请输入密码",text:"1234567"})
          .fontColor(Color.Black).fontSize(20)
          .type(InputType.Password)
          .maxLength(16)
          .height(45).onChange((val)=>{
          this.loginPassWord = val
          if (this.loginPhone.length==11 && this.loginPassWord.length>6 && this.loginPassWord.length<=16) {
            this.enabledBtn = true;
          }else{
            this.enabledBtn = false;
          }

        })

        Button('登录').height(45).width('100%').backgroundColor(this.colorBtnBg).borderRadius(20).onClick(()=>{
          // hilog.info(0x0000, 'testTag', 'loginPhone=%{public}s', this.loginPhone);
          // hilog.info(0x0000, 'testTag', 'loginPassWord=%{public}s', this.loginPassWord);
          // let map = {
          //   "username":this.loginPhone,
          //   "password":this.loginPassWord
          // }
          // this.add<BaseEntity<TextList>>('10039').then((result)=>{
          //   hilog.info(0x0000, 'testTag', 'this.add() =%{public}s',result.data.links.name)
          // })
          // this.addO1<BaseEntity<TextList>>('10039').then((result)=>{
          //   hilog.info(0x0000, 'testTag', 'this.add() =%{public}s',result.data.links.articleList[0].link)
          // })
          //增加header
          // httpHeaderMap.set("aaaaa","bbbbbbbbbbbbbbb")
          this.login<BaseEntity<LoginEntity>>(this.loginPhone,this.loginPassWord,((value)=>{
            hilog.info(0x0000, 'testTag', 'httpHeaderMap result=%{public}s', value);
          }),((value)=>{
            hilog.info(0x0000, 'testTag', 'httpHeaderMap cookie result=%{public}s', value);
          })
          )
            .then(async (result)=>{
              hilog.info(0x0000, 'testTag', 'result=%{public}s', result.data.username);
              if(result.errorCode==0){
                await preferenceUtil.put(Constants.USERNAME,this.loginPhone)
                await preferenceUtil.put(Constants.PASSWORD,this.loginPassWord)

                 Utils.getMainLayout()
              }else{
                ShowToastUtils.show(result.errorMsg)
              }
            }).catch((error)=>{
            hilog.info(0x0000, 'testTag', 'error=%{public}s',JSON.stringify(error));
          })
          // let map ="username="+this.loginPhone+"&password="+this.loginPassWord
          // hilog.info(0x0000, 'testTag', 'loginPassWord=%{public}s',JSON.stringify(map));
          // HttpManager
          //   .getInstance().postFrom<BaseEntity<LoginEntity>>(
          //   "https://www.wanandroid.com/user/login",
          //   map,
          //   this.getHeader,
          //   this.getCookie
          // ).then((result)=>{
          //   hilog.info(0x0000, 'testTag', 'result=%{public}s', result.errorMsg);
          //   if(result.errorCode==0){
          //     PreferencesUtils.put(USERNAME,this.loginPhone)
          //     PreferencesUtils.put(PASSWORD,this.loginPassWord)
          //     Utils.getMainLayout()
          //   }else{
          //     ShowToastUtils.show(result.errorMsg)
          //   }
          // }).catch((error)=>{
          //   hilog.info(0x0000, 'testTag', 'error=%{public}s',JSON.stringify(error));
          // })
        }).onHover((isHover)=>{
          if (isHover) {
            if(isHover){
              this.colorBtnBg = '#46CDD0'
            }else {
              this.colorBtnBg ='#3E84A6'
            }
          }
        }).enabled(this.enabledBtn)

        Text("注册")
          .decoration({
            type:TextDecorationType.Underline,
            color:Color.Red,
          })
          .lineHeight(20)
          .fontColor(Color.Blue)
          .fontSize(18)
          .align(Alignment.Bottom)
          .onClick(()=>{
            router.pushUrl({url:REGISTER}).then(()=>{
              hilog.info(0x0000, 'testTag', '注册=%{public}s','success');
            }).catch((error)=>{
              hilog.info(0x0000, 'testTag', '注册=%{public}s',JSON.stringify(error));
            })
          })
      }
      .width('90%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
  // @GetMethod("https://wanandroid.com/harmony/index/json")
  // add<T>(@Param('user') user:string):Promise<T>{
  //   return
  // }
  // @GetMethod("https://wanandroid.com/harmony/index/json")
  // addO1<T>(@Param('user') user:string):Promise<T>{
  //   return
  // }
  //let map ="username="+this.loginPhone+"&password="+this.loginPassWord
  @PostMethod("https://www.wanandroid.com/user/login")
  login<T>(@Param('username') username:string,
           @Param('password') password:string,
           @FunctionFunctionParam("header") header:(value)=>void,
           @FunctionFunctionParam("cookie") cookie:(value)=>void
  ):Promise<T>{
    return
  }
  getHeader(header:string){
    hilog.info(0x0000, 'testTag', 'header=%{public}s', header);
  }
  getCookie(cookie:string){
    hilog.info(0x0000, 'testTag', 'cookie=%{public}s', cookie);
  }
}

