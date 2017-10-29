
import AppKit
import AVFoundation

class VideoView: NSView {
  
  let displayLayer: AVSampleBufferDisplayLayer
  
  init() {
    displayLayer = AVSampleBufferDisplayLayer()
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    layer = displayLayer
    wantsLayer = true
    displayLayer.videoGravity = .resizeAspectFill
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  func enqueue(frameBuffer: Data) {
    guard let sampleBuffer = VideoFrameDecodeBinary(data: frameBuffer) else {
      return
    }
    displayLayer.enqueue(sampleBuffer)
  }
  
}

