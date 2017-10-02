
import Darwin
import Foundation

struct UdpSocket {
  
  let handle: Int32
  let address: sockaddr
  
  func close() {
    Darwin.close(handle)
  }
  
  func send(data: Data) -> Bool {
    var localAddress = address
    let bytes = [UInt8](data)
    let addressSize = socklen_t(MemoryLayout<sockaddr>.size)
    let sentCount = sendto(handle, bytes, bytes.count, 0, &localAddress, addressSize)
    return sentCount != -1
  }
  
  static func resolve(host: String, port: UInt16, callback: @escaping (UdpSocket?) -> Void) {
    DispatchQueue.global().async {
      let port = String(port)
      var hints = addrinfo(ai_flags: 0, ai_family: AF_INET, ai_socktype: SOCK_DGRAM, ai_protocol: IPPROTO_UDP, ai_addrlen: 0, ai_canonname: nil, ai_addr: nil, ai_next: nil)
      var result = nil as UnsafeMutablePointer<addrinfo>?
      let returnStatus = getaddrinfo(host, port, &hints, &result)
      let socketHandle = Darwin.socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP)
      guard returnStatus == 0, socketHandle != -1, let address = result?.pointee.ai_addr.pointee else {
        DispatchQueue.main.async {
          callback(nil)
        }
        return
      }
      freeaddrinfo(result)
      let socket = UdpSocket(handle: socketHandle, address: address)
      DispatchQueue.main.async {
        callback(socket)
      }
    }
  }
  
}
