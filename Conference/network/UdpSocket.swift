
import Darwin
import Foundation

class UdpSocket {
  
  let handle: Int32
  var addressInfo: UnsafeMutablePointer<addrinfo>?
  
  init?() {
    handle = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP)
    guard handle != -1 else {
      return nil
    }
  }
  
  deinit {
    close(handle)
  }
  
  func send(data: Data) -> Bool {
    guard let address = addressInfo?.pointee.ai_addr else {
      return false
    }
    let bytes = [UInt8](data)
    let addressSize = socklen_t(MemoryLayout<sockaddr>.size)
    let sentCount = sendto(handle, bytes, bytes.count, 0, address, addressSize)
    return sentCount != -1
  }
  
  func resolve(host: String, port: UInt16, queue: DispatchQueue, callback: @escaping (Bool) -> Void) {
    queue.async {
      let port = String(port)
      let hints = UnsafeMutablePointer<addrinfo>.allocate(capacity: 1)
      let result = UnsafeMutablePointer<UnsafeMutablePointer<addrinfo>?>.allocate(capacity: 1)
      defer {
        hints.deallocate(capacity: 1)
        result.deallocate(capacity: 1)
      }
      hints.pointee = addrinfo(ai_flags: 0, ai_family: AF_INET, ai_socktype: SOCK_DGRAM, ai_protocol: IPPROTO_UDP, ai_addrlen: 0, ai_canonname: nil, ai_addr: nil, ai_next: nil)
      let returnStatus = getaddrinfo(host, port, hints, result)
      guard returnStatus == 0 else {
        callback(false)
        return
      }
      self.addressInfo = result.pointee
      callback(true)
    }
  }
  
}
