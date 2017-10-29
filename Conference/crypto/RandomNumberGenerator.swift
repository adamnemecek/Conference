
import Darwin
import Foundation

func RandomNumberGenerator(count: Int) -> [UInt8] {
  var buffer = [UInt8](repeating: 0, count: count)
  _ = SecRandomCopyBytes(kSecRandomDefault, count, &buffer)
  return buffer
}

func RandomNumberGenerator(bound: UInt32) -> UInt32 {
  return arc4random_uniform(bound)
}
