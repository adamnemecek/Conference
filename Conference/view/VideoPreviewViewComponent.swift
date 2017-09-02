
import AppKit
import AVFoundation

class VideoPreviewViewComponent {
  
  let view: NSView
  
  init(layer: AVCaptureVideoPreviewLayer) {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer = layer
    view.wantsLayer = true
    layer.videoGravity = .resizeAspectFill
    layer.connection?.automaticallyAdjustsVideoMirroring = false
    layer.connection?.isVideoMirrored = true
  }
  
}
