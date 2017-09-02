
import AppKit

class VideoSessionController {
  
  let animationTime: TimeInterval
  let videoSession: VideoSession
  let previewViewComponent: VideoPreviewViewComponent
  
  var contentView: NSView {
    return previewViewComponent.view
  }
  
  init() {
    animationTime = 1
    videoSession = VideoSession()
    previewViewComponent = VideoPreviewViewComponent(layer: videoSession.previewLayer)
    videoSession.delegate = self
    NSView.hide(views: contentView)
  }
  
}

extension VideoSessionController: VideoSessionDelegate {
  
  func didFail(session: VideoSession) {
    NSView.hide(views: contentView, duration: animationTime)
  }

  func didStop(session: VideoSession) {
    NSView.hide(views: contentView, duration: animationTime)
  }

  func didStart(session: VideoSession) {
    NSView.show(views: contentView, duration: animationTime)
  }
  
  func videoSession(_ session: VideoSession, didReceiveBuffer buffer: Data) {
    
  }
  
}
