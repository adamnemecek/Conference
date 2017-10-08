
func Sha256(data: [UInt8]) -> [UInt8] {
  let bufferSize = Int(CC_SHA256_DIGEST_LENGTH)
  let hashSize = CC_LONG(CC_SHA256_DIGEST_LENGTH)
  var hashBuffer = [UInt8](repeating: 0, count: bufferSize)
  CC_SHA256(data, hashSize, &hashBuffer)
  return hashBuffer
}
