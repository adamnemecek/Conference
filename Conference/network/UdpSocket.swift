
import Darwin
import Foundation

struct UdpSocket {
  
  let handle: Int32
  
  func close() {
    Darwin.close(handle)
  }
  
  func send(data: Data) {
    DispatchQueue.global().async {
      data.withUnsafeBytes { dataBuffer in
        Darwin.send(self.handle, dataBuffer, data.count, 0)
      }
    }
  }
  
  func receive(queue: DispatchQueue, callback: @escaping (Data) -> Void) {
    DispatchQueue.global().async {
      let maxDatagramSize = Int(UInt16.max)
      var data = Data(capacity: maxDatagramSize)
      let receivedByteCount = data.withUnsafeMutableBytes { dataBuffer in
        return Darwin.recv(self.handle, dataBuffer, maxDatagramSize, 0)
      }
      guard receivedByteCount != -1 else {
        return
      }
      data.count = receivedByteCount
      queue.async {
        callback(data)
      }
    }
  }
  
  static func connect(host: String, port: UInt16, queue: DispatchQueue, callback: @escaping (UdpSocket?) -> Void) {
    DispatchQueue.global().async {
      var udpSocket = nil as UdpSocket?
      defer {
        queue.async {
          callback(udpSocket)
        }
      }
      let port = String(port)
      var hints = Darwin.addrinfo(ai_flags: 0, ai_family: Darwin.AF_INET, ai_socktype: Darwin.SOCK_DGRAM, ai_protocol: Darwin.IPPROTO_UDP, ai_addrlen: 0, ai_canonname: nil, ai_addr: nil, ai_next: nil)
      var result = nil as UnsafeMutablePointer<Darwin.addrinfo>?
      let getaddrinfoResult = Darwin.getaddrinfo(host, port, &hints, &result)
      guard getaddrinfoResult == 0, let info = result?.pointee else {
        return
      }
      Darwin.freeaddrinfo(result)
      let socketHandle = socket(Darwin.AF_INET6, Darwin.SOCK_DGRAM, Darwin.IPPROTO_UDP)
      guard socketHandle != -1 else {
        return
      }
      let connectResult = Darwin.connect(socketHandle, info.ai_addr, info.ai_addrlen)
      guard connectResult == 0 else {
        return
      }
      udpSocket = UdpSocket(handle: socketHandle)
    }
  }
  
}
