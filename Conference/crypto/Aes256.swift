
struct Aes256Key {
  
  let bytes: [UInt8]
  
  init(password: String, salt: [UInt8]) {
    let pbkdfAlgorithm = CCPBKDFAlgorithm(kCCPBKDF2)
    let hashAlgorithm = CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256)
    let rounds = UInt32(8192)
    var key = [UInt8](repeating: 0, count: kCCKeySizeAES128)
    CCKeyDerivationPBKDF(pbkdfAlgorithm, password, password.characters.count, salt, salt.count, hashAlgorithm, rounds, &key, kCCKeySizeAES128)
    bytes = key
  }
  
}

struct Aes256InitializationVector {
  
  let bytes: [UInt8]
  
  init() {
    bytes = RandomNumberGenerator(count: kCCBlockSizeAES128)
  }
  
}

func Aes256Encrypt(cleartext: [UInt8], key: Aes256Key, iv: Aes256InitializationVector) -> [UInt8] {
  let operation = CCOperation(kCCEncrypt)
  let algorithm = CCAlgorithm(kCCAlgorithmAES)
  let options = CCOptions(kCCOptionPKCS7Padding)
  var ciphertext = [UInt8](repeating: 0, count: cleartext.count + kCCBlockSizeAES128)
  var encryptedSize = 0
  CCCrypt(operation, algorithm, options, key.bytes, key.bytes.count, iv.bytes, cleartext, cleartext.count, &ciphertext, ciphertext.count, &encryptedSize)
  return Array(ciphertext[0..<encryptedSize])
}

func Aes256Decrypt(ciphertext: [UInt8], key: Aes256Key, iv: Aes256InitializationVector) -> [UInt8] {
  let operation = CCOperation(kCCDecrypt)
  let algorithm = CCAlgorithm(kCCAlgorithmAES)
  let options = CCOptions(kCCOptionPKCS7Padding)
  var cleartext = [UInt8](repeating: 0, count: ciphertext.count)
  var encryptedSize = 0
  CCCrypt(operation, algorithm, options, key.bytes, key.bytes.count, iv.bytes, ciphertext, ciphertext.count, &cleartext, cleartext.count, &encryptedSize)
  return Array(cleartext[0..<encryptedSize])
}
