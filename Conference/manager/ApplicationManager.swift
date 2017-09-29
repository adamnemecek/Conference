
import AppKit

class ApplicationManager {
  
  static let shared = ApplicationManager()
  
  let menuManager: MenuManager
  let mainController: MainController
  
  init() {
    menuManager = MenuManager()
    mainController = MainController()
    menuManager.delegate = self
  }
  
  func run() {
    NotificationCenter.default.addObserver(forName: NSApplication.didFinishLaunchingNotification, object: nil, queue: nil) { notification in
      self.mainController.window.makeKeyAndOrderFront(self)
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
