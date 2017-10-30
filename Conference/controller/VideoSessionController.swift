
import AppKit
import AVFoundation

class VideoSessionController {
  
  let animationTime: TimeInterval
  let videoSession: VideoSession
  let videoPreviewView: VideoPreviewView
  let videoView: VideoView
  
  var view: NSView {
    return videoView
  }
  
  init() {
    animationTime = 1
    videoSession = VideoSession()
    videoPreviewView = VideoPreviewView(previewLayer: videoSession.previewLayer)
    videoView = VideoView()
    videoSession.delegate = self
    NSView.hide(views: view)
  }
  
}

extension VideoSessionController: VideoSessionDelegate {
  
  func videoSession(_ session: VideoSession, didReceiveFrameBuffer buffer: Data) {
    videoView.enqueue(frameBuffer: buffer)
  }
  
  func didFail(session: VideoSession) {
    NSView.hide(views: view, duration: animationTime)
  }

  func didStop(session: VideoSession) {
    NSView.hide(views: view, duration: animationTime)
  }

  func didStart(session: VideoSession) {
    NSView.show(views: view, duration: animationTime)
  }
  
}

extension VideoSessionController: ViewController {
  
  func layoutSubviews() {
    
  }
  
}
