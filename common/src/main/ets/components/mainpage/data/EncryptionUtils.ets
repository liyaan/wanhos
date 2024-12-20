import cryptoFramework from '@ohos.security.cryptoFramework'
import util from '@ohos.util'
import buffer from '@ohos.buffer'
export class EncryptionUtils{
  static  base64Encode(str: string) {
    let blob: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(str, 'utf-8').buffer) }
    let base64Helper = new util.Base64Helper()
    return base64Helper.encodeToStringSync(blob.data)
  }

  static base64Decode(input: string){
    let base64Helper = new util.Base64Helper()
    let uint8Array = base64Helper.decodeSync(input)
    return buffer.from(uint8Array).toString("utf-8")
  }
}
