@Entry
@Component
struct  ArkTSBase{
  build(){
    Column(){
      Text('文本') //显示的文案 1.直接输入文字 2.设备国际化的需要调用resources/en_US和zh_US/string.json  Text($r('app.string.user'))
        .lineHeight(25) //行高
        .fontColor(Color.Black) //设置字体颜色
        .fontSize(18)//设置字体大小
        .fontWeight(FontWeight.Bold) //设置字体的粗细
        .textOverflow({overflow:TextOverflow.Ellipsis}) //设置超出部分显示省略号
        .maxLines(1)//设置最大的行数
        .minFontSize(15) //设置最小字体
        .maxFontSize(20) //设置最大字体 ---在页面适配中 使用

      //Image 1.string格式，通常用来加载网络图片 需要申请网络权限 Image("图片的Url地址")
      //Image 2.PixelMap格式，可以加载像素图，常用在图片编辑中 Image(pixeMapObject)
      //Image 3.Resource格式，加载本地图片，推荐使用       Image($r('app .media .icon') Image($rawfile( 'icon .png'))
      //.objectFit(ImageFit.Auto) Contain 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内.
      //                           Cover: 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
      //                            Auto: 自适应显示。
      //                            Fill: 不保持宽高比进行放大缩小，使得图片充满显示边界。
      //                            ScaleDown: 保持宽高比显示，图片缩小或者保持不变。
      //                            None: 保持原有尺寸显示。
      Image("https://wx4.sinaimg.cn/mw690/005MXVYEgy1ht3ls25bmbj30u00u0wi4.jpg")
        .width(100)
        .height(100)
        .borderWidth(2) //边框高度
        .borderColor(Color.Black) //边框
        .borderRadius(50) //设置圆角
        .objectFit(ImageFit.Auto) // Contain 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内. Cover: 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
        .aspectRatio(1) // 宽高比
      //TextInput 输入框
      // TextInputOptions对象格式    placeholder:输入框无输入时的提示文本
      TextInput({placeholder:"请输入手机号"})
        .height(40)
        .width('100%')
        .backgroundColor('#36D') //背景色
        .type(InputType.Password) //文本框类型
        .showPasswordIcon(false)      //密码输入模式时，输入框末尾的图标是否显示
        .onChange(val=>{
          //文本框改变事件  value参数为文本框输入的内容
        })
      //文字类型
      //ButtonType.Normal 普通按钮(默认不带圆角)  Capsule俗称胶囊按钮 圆角为高度的一半 Circle 圆形按钮
      Button("点我").width(100)
        .height(30)
        .type(ButtonType.Normal)   //按钮类型
        .onClick(()=>{
          //处理点击事件
        })
      //自定义按钮，在Button内嵌套其它组件
      Button(){
        Image($r('app.media.icon')).width(20).height(15)
      }.width(20).height(15)

      //Slider

      Slider({
        value: 200,  //当前的滑动条的值
        min:100,//滑动条最小值
        max:500,//滑动条最大值
        step:10, //滑动步长
        style:SliderStyle.InSet, //滑动与滑轨的样式
        direction:Axis.Horizontal,
        reverse:false
      }).width('90%')
        .showTips(true)      //显示滑动条百分比
        .backgroundColor('#FFF')     //背景颜色
        .onChange(value=>{
          //value为当前滑块值
        })
      Row({space:10}){
        Text('性别:').fontSize(20).padding({left:10 })
        //基础组件 单选框组件
        Radio({value:'男',group:'sex'})
          .width(20)
          .height(20)
          .checked(true) //是否选中
          .onChange((isChecked)=>{
            if(isChecked){  //选中 isChecked为true 未选中为false
              console.log('男')
            }
          })
        Text('男').fontSize(20)
        Radio({value:'女',group:'sex'})
          .width(20)
          .height(20)
          .checked(true) //是否选中
          .onChange((isChecked)=>{
            if(isChecked){  //选中 isChecked为true 未选中为false
              console.log('女')
            }
          })
        Text('女').fontSize(20)
      }.width('100%')

      Row(){
        Text('地址:').fontSize(20).padding({left:10 })
        //基础组件 下拉框组件
        Select([{value:'长沙'},{value:'北京'},{value:'广州'},{value:'上海'}])
          .selected(2) //默认选中某一项 数组的索引值
          .value('请选择地址') //设置下拉按钮本身的文本内容
          .font({size:16,weight:FontWeight.Medium})
          .onSelect((index: number,value:string)=>{
            console.log('select: '+ index + ',值:'+value)
          })
      }.width('100%')


      //基础组件  多选框组件
      //多选框组件控制组件

      Row(){
        Text('爱好:').fontSize(20).padding({left:10 })
        CheckboxGroup({group:'checkboxGroup'})
          .selectedColor('#007DFF')
          .selectAll(true)
          .onChange((itemName: CheckboxGroupResult) => {
            console.info("checkbox group content" + JSON.stringify(itemName))
          })
        Text('全选').fontSize(20)
        //选项1
        Checkbox({name:'checkbox1',group:'checkboxGroup'})
          .selectedColor('#007DFF')     //选中的颜色
          .select(true)  //是否选中
          .onChange((value:Boolean)=>{
            console.log('Checkbox1 change is '+ value)
          })
        Text('java').fontSize(20)
        //选项2
        Checkbox({name:'checkbox2',group:'checkboxGroup'})
          .selectedColor('#007DFF')     //选中的颜色
          .select(false)  //是否选中
          .onChange((value:Boolean)=>{
            console.log('Checkbox1 change is '+ value)
          })
        Text('kotlin').fontSize(20)

        //选项3
        Checkbox({name:'checkbox3',group:'checkboxGroup'})
          .selectedColor('#007DFF')     //选中的颜色
          .select(false)  //是否选中
          .onChange((value:Boolean)=>{
            console.log('Checkbox1 change is '+ value)
          })
        Text('arkts').fontSize(20)
      }.width('100%')
    }
  }
}