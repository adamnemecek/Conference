
import AppKit

class ApplicationManager {
  
  static let shared = ApplicationManager()
  
  let window: NSWindow
  let navigationController = NavigationController()
  let startController = StartViewController()
  let connectionController = ConnectionController()
  let videoSessionController = VideoSessionController()
  let mouseEventMonitor = MouseEventMonitor()
  let menuManager = MenuManager()
  
  init() {
    let windowSize = CGSize(width: 400, height: 300)
    let screenFrame = NSScreen.main!.frame
    let deltaX = (screenFrame.size.width - windowSize.width) / 2
    let deltaY = (screenFrame.size.height - windowSize.height) / 2
    let windowFrame = screenFrame.insetBy(dx: deltaX, dy: deltaY)
    let styleMask = [
      .titled,
      .fullSizeContentView,
      .miniaturizable,
      .resizable
      ] as NSWindow.StyleMask
    window = NSWindow(contentRect: windowFrame, styleMask: styleMask, backing: .buffered, defer: false)
    window.titlebarAppearsTransparent = true
    window.isMovableByWindowBackground = true
    window.contentView = navigationController.contentView
    
    connectionController.delegate = self
    mouseEventMonitor.delegate = self
    menuManager.delegate = self
    
    navigationController.present(view: startController.view, transition: .none)
  }
  
  func run() {
    NotificationCenter.default.addObserver(forName: NSApplication.didFinishLaunchingNotification, object: nil, queue: nil) { notification in
      self.window.makeKeyAndOrderFront(self)
    }
    NSApplication.shared.mainMenu = menuManager.mainMenu
    NSApplication.shared.run()
  }
  
}

extension ApplicationManager: MenuManagerDelegate {
  
  func aboutConference() {
    NSApplication.shared.orderFrontStandardAboutPanel(self)
  }
  
  func quit() {
    NSApplication.shared.terminate(self)
  }
  
}

extension ApplicationManager: ConnectionControllerDelegate {
  
  func didConnect() {
    navigationController.present(view: videoSessionController.view, transition: .none)
    videoSessionController.videoSession.start()
  }
  
}

extension ApplicationManager: MouseEventMonitorDelegate {
  
  func didMove() {
    NSView.show(views: window.standardButtons)
  }
  
  func didStopAfterTimeInterval() {
    NSView.hide(views: window.standardButtons, duration: 1)
  }
  
}
