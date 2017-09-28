
import Foundation
import Darwin

class UdpSocket {
  
  let handle: Int32
  let target: UnsafeMutablePointer<Darwin.sockaddr>
  let queue: DispatchQueue
  
  init?() {
    handle = Darwin.socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP)
    guard handle != -1 else {
      return nil
    }
    target = UnsafeMutablePointer<Darwin.sockaddr>.allocate(capacity: 1)
    queue = DispatchQueue(label: "UdpSocket")
  }
  
  func send(data: Data) -> Bool {
    let bytes = [UInt8](data)
    let addressSize = socklen_t(MemoryLayout<Darwin.sockaddr>.size)
    let sentCount = Darwin.sendto(handle, bytes, bytes.count, 0, target, addressSize)
    return sentCount != -1
  }
  
  func close() {
    Darwin.close(handle)
  }
  
  func connect(host: String, port: Int, callback: @escaping (Bool) -> Void) {
    queue.async {
      let port = String(port)
      var hints = addrinfo(ai_flags: 0, ai_family: AF_INET, ai_socktype: SOCK_DGRAM, ai_protocol: IPPROTO_UDP, ai_addrlen: 0, ai_canonname: nil, ai_addr: nil, ai_next: nil)
      var result: UnsafeMutablePointer<addrinfo>? = nil
      guard getaddrinfo(host, port, &hints, &result) == 0 else {
        DispatchQueue.main.async {
          callback(false)
        }
        return
      }
      DispatchQueue.main.async {
        callback(true)
      }
    }
  }
  
}
