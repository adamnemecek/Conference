
import Foundation

func Sha256(data: Data) -> Data {
  let bufferSize = Int(CC_SHA256_DIGEST_LENGTH)
  var hashBuffer = Data(count: bufferSize)
  let hashSize = CC_LONG(CC_SHA256_DIGEST_LENGTH)
  data.withUnsafeBytes { bytes in
    hashBuffer.withUnsafeMutableBytes { buffer in
      _ = CC_SHA256(bytes, hashSize, buffer)
    }
  }
  return hashBuffer
}
