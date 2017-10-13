
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
