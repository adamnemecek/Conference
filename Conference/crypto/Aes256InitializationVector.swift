
struct Aes256InitializationVector {
  
  let bytes: [UInt8]
  
  init() {
    bytes = RandomNumberGenerator(count: kCCBlockSizeAES128)
  }
  
}
