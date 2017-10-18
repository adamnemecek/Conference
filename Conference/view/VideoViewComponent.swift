
import AppKit
import AVFoundation

class VideoViewComponent {
  
  let view: NSView
  let displayLayer: AVSampleBufferDisplayLayer
  
  init() {
    view = NSView()
    displayLayer = AVSampleBufferDisplayLayer()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer = displayLayer
    view.wantsLayer = true
    displayLayer.videoGravity = .resizeAspectFill
  }
  
  func enqueue(frameBuffer: Data) {
    guard let sampleBuffer = VideoFrameDecodeBinary(data: frameBuffer) else {
      return
    }
    
  }
  
}

