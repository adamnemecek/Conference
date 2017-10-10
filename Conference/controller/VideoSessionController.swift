
import AppKit
import AVFoundation

class VideoSessionController {
  
  let animationTime: TimeInterval
  let videoSession: VideoSession
  let videoPreviewViewComponent: VideoPreviewViewComponent
  let videoViewComponent: VideoViewComponent
  
  var contentView: NSView {
    return videoViewComponent.view
  }
  
  init() {
    animationTime = 1
    videoSession = VideoSession()
    videoPreviewViewComponent = VideoPreviewViewComponent(layer: videoSession.previewLayer)
    videoViewComponent = VideoViewComponent()
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
  
  func videoSession(_ session: VideoSession, didReceiveBuffer buffer: CMSampleBuffer) {
    videoViewComponent.displayLayer.enqueue(buffer)
  }
  
}
