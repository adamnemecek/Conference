
import AppKit

extension NSMenu {
  
  func addItem(title: String, keyEquivalent: String? = nil, modifierMask: NSEvent.ModifierFlags = [], target: AnyObject, action: Selector) {
    let menuItem = NSMenuItem()
    menuItem.title = title
    menuItem.target = target
    menuItem.action = action
    if let keyEquivalent = keyEquivalent {
      menuItem.keyEquivalent = keyEquivalent
      menuItem.keyEquivalentModifierMask = modifierMask
    }
    addItem(menuItem)
  }
  
  func addSubmenu(title: String) -> NSMenu {
    let menuItem = NSMenuItem()
    let menu = NSMenu()
    menuItem.submenu = menu
    addItem(menuItem)
    return menu
  }
  
  func addSeperator() {
    let item = NSMenuItem.separator()
    addItem(item)
  }
  
}

extension NSView {
  
  func removeSubviews() {
    for view in subviews {
      view.removeFromSuperview()
    }
  }
  
  func removeConstraints() {
    for constraint in constraints {
      removeConstraint(constraint)
    }
  }
  
  static func hide(views: NSView..., duration: TimeInterval? = nil) {
    hide(views: views, duration: duration)
  }
  
  static func show(views: NSView..., duration: TimeInterval? = nil) {
    show(views: views, duration: duration)
  }
  
  static func hide(views: [NSView], duration: TimeInterval? = nil) {
    guard let duration = duration else {
      for view in views {
        view.alphaValue = 0
        view.isHidden = true
      }
      return
    }
    
    func fade(context: NSAnimationContext) {
      context.duration = duration
      for view in views {
        view.animator().alphaValue = 0
      }
    }
    
    NSAnimationContext.runAnimationGroup(fade)
  }
  
  static func show(views: [NSView], duration: TimeInterval? = nil) {
    guard let duration = duration else {
      for view in views {
        view.alphaValue = 1
        view.isHidden = false
      }
      return
    }
    
    func fade(context: NSAnimationContext) {
      context.duration = duration
      for view in views {
        view.animator().alphaValue = 1
      }
    }
    
    for view in views {
      view.isHidden = false
    }
    NSAnimationContext.runAnimationGroup(fade)
  }
  
}

extension NSWindow {
  
  var standardButtons: [NSButton] {
    let buttons = [
      standardWindowButton(.closeButton),
      standardWindowButton(.miniaturizeButton),
      standardWindowButton(.zoomButton),
      standardWindowButton(.toolbarButton),
      standardWindowButton(.documentIconButton),
      standardWindowButton(.documentVersionsButton)
    ]
    return buttons.flatMap { button in
      return button
    }
  }
  
}
