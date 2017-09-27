
import Foundation
import Darwin

class UdpSocket {
  
  let host: String
  let port: Int
  let queue = DispatchQueue(label: "foo")
  
  init(host: String, port: Int) {
    self.host = host
    self.port = port
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
