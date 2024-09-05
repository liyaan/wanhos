
import { ConsoleUtils } from './ConsoleUtils'

export class Log {
  static info(message) {
    ConsoleUtils.log(message)
  }
  static log(message) {
    ConsoleUtils.log(message)
  }
  static error(message) {
    ConsoleUtils.error(message)
  }
  static infoTag(message) {
    ConsoleUtils.log(message)
  }

  static errorTag(message) {
    ConsoleUtils.error(message)
  }
}