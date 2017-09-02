
import AppKit

protocol MenuManagerDelegate: class {
  
  func aboutConference()
  func quit()
  
}

class MenuManager {
  
  let mainMenu: NSMenu
  
  weak var delegate: MenuManagerDelegate?
  
  init() {
    mainMenu = NSMenu()
    let conferenceMenu = mainMenu.addSubmenu(title: "Conference")
    conferenceMenu.addItem(title: "About Conference", target: self, action: #selector(MenuManager.aboutConference))
    conferenceMenu.addSeperator()
    conferenceMenu.addItem(title: "Quit Conference", keyEquivalent: "q", modifierMask: [.command], target: self, action: #selector(MenuManager.quit))
  }
  
}

@objc extension MenuManager {
  
  func aboutConference() {
    delegate?.aboutConference()
  }
  
  func quit() {
    delegate?.quit()
  }
  
}
