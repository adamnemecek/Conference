
import Foundation

enum Aes256CryptOperation {
  case encrypt
  case decrypt
  
  var ccOperation: CCOperation {
    switch self {
    case .encrypt:
      return CCOperation(kCCEncrypt)
    case .decrypt:
      return CCOperation(kCCDecrypt)
    }
  }
  
}

func Aes256Crypt(operation: Aes256CryptOperation,  data: Data, iv: Data, key: Data) -> Data? {
  let algorithm = CCAlgorithm(kCCAlgorithmAES)
  let options = CCOptions(kCCOptionPKCS7Padding)
  var ciphertext = Data(count: data.count + kCCBlockSizeAES128)
  var encryptedSize = 0
  let cryptStatus = data.withUnsafeBytes { dataBuffer in
    return key.withUnsafeBytes { keyBuffer in
      return iv.withUnsafeBytes { ivBuffer in
        return ciphertext.withUnsafeMutableBytes { ciphertextBuffer in
          return CCCrypt(operation.ccOperation, algorithm, options, keyBuffer, key.count, ivBuffer, dataBuffer, data.count, ciphertextBuffer, ciphertext.count, &encryptedSize)
        }
      }
    }
  }
  guard cryptStatus == kCCSuccess else {
    return nil
  }
  ciphertext.count = encryptedSize
  return ciphertext
}

func Aes256InitializationVector() -> Data? {
  var initializationVector = Data(count: kCCBlockSizeAES128)
  let status = initializationVector.withUnsafeMutableBytes { ivBuffer in
    return SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBuffer)
  }
  guard status == errSecSuccess else {
    return nil
  }
  return initializationVector
}

func Aes256Key(password: String) -> Data {
  return Data()
}
