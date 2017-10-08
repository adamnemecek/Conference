
func Aes256Encrypt(cleartext: [UInt8], password: String) -> [UInt8] {
  let operation = CCOperation(kCCEncrypt)
  let algorithm = CCAlgorithm(kCCAlgorithmAES)
  let options = CCOptions(kCCOptionPKCS7Padding)
  let salt = RandomNumberGenerator(count: kCCBlockSizeAES128)
  let iv = RandomNumberGenerator(count: kCCBlockSizeAES128)
  let key = Aes256Key(password: password, salt: salt)
  var ciphertext = [UInt8](repeating: 0, count: cleartext.count + kCCBlockSizeAES128)
  var encryptedSize = 0
  CCCrypt(operation, algorithm, options, key, key.count, iv, cleartext, cleartext.count, &ciphertext, ciphertext.count, &encryptedSize)
  return salt + iv + Array(ciphertext[0..<encryptedSize])
}

func Aes256Decrypt(ciphertext: [UInt8], password: String) -> [UInt8] {
  let operation = CCOperation(kCCDecrypt)
  let algorithm = CCAlgorithm(kCCAlgorithmAES)
  let options = CCOptions(kCCOptionPKCS7Padding)
  let salt = RandomNumberGenerator(count: kCCBlockSizeAES128)
  let iv = RandomNumberGenerator(count: kCCBlockSizeAES128)
  let key = Aes256Key(password: password, salt: salt)
  var cleartext = [UInt8](repeating: 0, count: ciphertext.count)
  var encryptedSize = 0
  CCCrypt(operation, algorithm, options, key, key.count, iv, ciphertext, ciphertext.count, &cleartext, cleartext.count, &encryptedSize)
  return salt + iv + Array(cleartext[0..<encryptedSize])
}

func Aes256Key(password: String, salt: [UInt8]) -> [UInt8] {
  let pbkdfAlgorithm = CCPBKDFAlgorithm(kCCPBKDF2)
  let hashAlgorithm = CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256)
  let rounds = UInt32(8192)
  var key = [UInt8](repeating: 0, count: kCCKeySizeAES128)
  CCKeyDerivationPBKDF(pbkdfAlgorithm, password, password.characters.count, salt, salt.count, hashAlgorithm, rounds, &key, kCCKeySizeAES128)
  return key
}
