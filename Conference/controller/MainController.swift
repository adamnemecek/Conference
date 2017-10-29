
import AppKit

class MainController {
  
  let window = MainControllerWindow()
  let containerController = ContainerController()
  let startController = StartController()
  let connectionController = ConnectionController()
  let videoSessionController = VideoSessionController()
  let mouseEventMonitor = MouseEventMonitor()
  
  init() {
    window.contentView = containerController.view
    containerController.present(contentView: connectionController.view, transition: .none)
    connectionController.delegate = self
    mouseEventMonitor.delegate = self    
  }
  
}

extension MainController: ConnectionControllerDelegate {
  
  func didConnect() {
    containerController.present(contentView: videoSessionController.view, transition: .none)
    videoSessionController.videoSession.start()
  }
  
}

extension MainController: MouseEventMonitorDelegate {
  
  func didMove() {
    NSView.show(views: window.standardButtons)
  }
  
  func didStopAfterTimeInterval() {
    NSView.hide(views: window.standardButtons, duration: 1)
  }
  
}

func MainControllerWindow() -> NSWindow {
  let windowSize = CGSize(width: 400, height: 300)
  let screenFrame = NSScreen.main!.frame
  let deltaX = (screenFrame.size.width - windowSize.width) / 2
  let deltaY = (screenFrame.size.height - windowSize.height) / 2
  let windowFrame = screenFrame.insetBy(dx: deltaX, dy: deltaY)
  let styleMask = [
    .titled,
    .fullSizeContentView,
    .closable,
    .miniaturizable,
    .resizable
  ] as NSWindow.StyleMask
  let window = NSWindow(contentRect: windowFrame, styleMask: styleMask, backing: .buffered, defer: false)
  window.titlebarAppearsTransparent = true
  window.isMovableByWindowBackground = true
  return window
}
