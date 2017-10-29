
import AppKit
import AVFoundation

class VideoPreviewView: NSView {
  
  init(previewLayer: AVCaptureVideoPreviewLayer) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    layer = previewLayer
    wantsLayer = true
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
    previewLayer.connection?.isVideoMirrored = true
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
}
