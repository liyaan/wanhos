@Extend(Button) function numberBtn(num: number, click: (num: number) => void) {
  .type(ButtonType.Capsule)
  .width(60)
  .height(60)
  .onClick(() => click(num))
}

// 运算符公共样式
@Extend(Button) function operatorBtn() {
  .type(ButtonType.Capsule)
  .backgroundColor(Color.Green)
  .width(60)
  .height(60)
}

// 额外功能公共样式
@Extend(Button) function extraBtn() {
  .type(ButtonType.Capsule)
  .width(60)
  .height(60)
  .fontColor(Color.White)
  .backgroundColor(Color.Gray)
}

PersistentStorage.PersistProp('lastResult', '0');

@Entry
@Component
struct CalculatePage{
  @StorageProp('lastResult') message: string = '0'
  @State error:string = ''
  calcFinished: boolean = true;

  @Styles numberRow() {
    .width('100%')
    .margin({ bottom: 10 })
  }

  build() {
    Column() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .width('100%')
          .textAlign(TextAlign.End)
      }
      .padding(10)
      .borderWidth(1)
      .borderRadius(10)
      .margin(10)


      Row() {
        Button('7').numberBtn(7, this.onNumberClick)
        Button('8').numberBtn(8, this.onNumberClick)
        Button('9').numberBtn(9, this.onNumberClick)
        Button('重置').extraBtn().onClick(this.onResetClick)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .numberRow()

      Row() {
        Button('4').numberBtn(4, this.onNumberClick)
        Button('5').numberBtn(5, this.onNumberClick)
        Button('6').numberBtn(6, this.onNumberClick)
        Button('删除').extraBtn().onClick(this.onDeleteClick)

      }
      .numberRow()
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('1').numberBtn(1, this.onNumberClick)
        Button('2').numberBtn(2, this.onNumberClick)
        Button('3').numberBtn(3, this.onNumberClick)
        Button('清理').extraBtn().onClick(this.onClearClick)
      }
      .numberRow()
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('%')
          .type(ButtonType.Capsule)
          .width(60)
          .height(60)
          .onClick(() => this.onOperatorClick('%'))
        Button('0').numberBtn(0, this.onNumberClick)
        Button('.')
          .type(ButtonType.Capsule)
          .width(60)
          .height(60)
          .onClick(this.onDotClick)
        Button('保存').operatorBtn().onClick(this.onSaveClick)
      }
      .numberRow()
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('x')
          .operatorBtn()
          .onClick(() => this.onOperatorClick('x'))
        Button('÷')
          .operatorBtn()
          .onClick(() => this.onOperatorClick('÷'))
        Button('+')
          .operatorBtn()
          .onClick(() => this.onOperatorClick('+'))
        Button('-')
          .operatorBtn()
          .onClick(() => this.onOperatorClick('-'))
      }
      .numberRow()
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Button('=')
          .width('100%')
          .fontColor('#fff')
          .backgroundColor(Color.Green)
          .onClick(this.onCalcClick)
      }
      .margin(10)
    }
    .height('100%')
  }

  resetCheck() {
    if (this.calcFinished) {
      this.message = '0';
      this.calcFinished = false;
    }
  }

  onNumberClick = (num: number) => {
    this.resetCheck();
    if (this.message === '0') {
      this.message = `${num}`;
    } else {
      this.message += `${num}`
    }
  }
  onOperatorClick = (_opt: string) => {
    this.message += _opt;
    this.calcFinished = false;
  }
  onDotClick = () => {
    this.resetCheck();
    this.message += '.';
  }
  onResetClick = () => {
    this.message = '0';
    this.calcFinished = true;
  }
  onDeleteClick = () => {
    this.resetCheck();
    if (this.message.length > 1) {
      this.message = this.message.substr(0, this.message.length - 1);
    } else {
      this.message = '0'
    }
  }
  onSaveClick = () => {
    AppStorage.SetOrCreate('lastResult', this.message);
  }
  onClearClick = () => {
    PersistentStorage.DeleteProp('lastResult')
    this.message = '0';
  }
  onCalcClick = () => {
    if(this.message.substring(0,1)==="-"){
      this.message = '0'+this.message
    }
    this.message = calculateByString(this.message.replace(/x/g, '*').replace(/÷/g, '/')) + '';
    this.calcFinished = true;
  }

}
export type Operator = '+' | '-' | '*' | '/' | '(' | ')' | '%';

const applyOperator = (a: number, b: number, op: Operator): number => {
  switch (op) {
    case '+':
      return a + b
    case '-':
      return a - b
    case '*':
      return a * b
    case '/':
      return a / b
    case '%':
      return a % b
    default:
      throw new Error(`Unknown operator: ${op}`);
  }
};



export function calculateByString(expression: string): number {
  const numbers: number[] = [];
  const operators: Operator[] = [];
  const precedence: Record<string, number> = { '+': 1, '-': 1, '*': 2, '/': 2 ,'%':2};

  const parse = (expr: string): void => {
    let numBuffer: string = '';
    for (const char of expr) {
      if (char === ' ') continue;
      if ('0' <= char && char <= '9' || char === '.') {
        numBuffer += char;
      } else {
        if (numBuffer !== '') {
          numbers.push(parseFloat(numBuffer));
          numBuffer = '';
        }
        if (char === '(') operators.push(char);
        else if (char === ')') {
          while (operators[operators.length - 1] !== '(') {
            const op = operators.pop() !;
            const b = numbers.pop() !;
            const a = numbers.pop() !;
            if (op === '/') {
              if (b==0) {
                numbers.pop()
                operators.pop()
                numbers.push(0)
                break
              }
            }
            numbers.push(applyOperator(a, b, op));
          }
          operators.pop();
        } else if ('+-*/%'.includes(char)) {
          while (operators.length && precedence[operators[operators.length - 1]] >= precedence[char]) {
            const op = operators.pop() !;
            const b = numbers.pop() !;
            const a = numbers.pop() !;
            if (op === '/') {
              if (b==0) {
                numbers.pop()
                operators.pop()
                numbers.push(0)
                break
              }
            }
            numbers.push(applyOperator(a, b, op));
          }
          operators.push(char as Operator);
        }
      }
    }
    if (numBuffer !== '') {
      numbers.push(parseFloat(numBuffer));
    }
  };

  parse(expression);

  while (operators.length) {
    const op = operators.pop() !;
    const b = numbers.pop() !;
    const a = numbers.pop() !;
    if (op === '/') {
      if (b==0) {
        numbers.pop()
        operators.pop()
        numbers.push(0)
        break
      }
    }
    numbers.push(applyOperator(a, b, op));
  }

  if (numbers.length !== 1) {
    throw new Error('Invalid expression');
  }

  return numbers[0];
}