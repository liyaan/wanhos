export class ConsoleUtils {
  static readonly TAG = 'UserData';

  static log(message) {
    console.log(this.TAG + "," + message)
  }

  static info(message) {
    console.info(this.TAG + "," + message)
  }

  static error(message) {
    console.error(this.TAG + "," + message)
  }
}