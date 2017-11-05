
import AppKit

extension NSStackView {
  
  convenience init(views: NSView...) {
    self.init(views: views)
  }
  
}

extension CALayer {
  

  var movedAnchorPoint: CGPoint {
    get {
      return anchorPoint
    }
    set(value) {
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      let newPoint = CGPoint(x: bounds.size.width * value.x, y: bounds.size.height * value.y)
      let oldPoint = CGPoint(x: bounds.size.width * anchorPoint.x, y: bounds.size.height * anchorPoint.y)
      position.x -= oldPoint.x
      position.x += newPoint.x
      position.y -= oldPoint.y
      position.y += newPoint.y
      anchorPoint = value
      CATransaction.commit()
    }
  }
  
}

extension CGSize {
  
  func inset(horizontal: CGFloat, vertical: CGFloat) -> CGSize {
    let width = horizontal + self.width + horizontal
    let height = vertical + self.height + vertical
    return CGSize(width: width, height: height)
  }
  
}

extension NSColor {
  
  convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8 = UInt8.max) {
    let r = CGFloat(red) / CGFloat(UInt8.max)
    let g = CGFloat(green) / CGFloat(UInt8.max)
    let b = CGFloat(blue) / CGFloat(UInt8.max)
    let a = CGFloat(alpha) / CGFloat(UInt8.max)
    self.init(deviceRed: r, green: g, blue: b, alpha: a)
  }
  
  convenience init(white: UInt8, alpha: UInt8 = UInt8.max) {
    let w = CGFloat(white) / CGFloat(UInt8.max)
    let a = CGFloat(alpha) / CGFloat(UInt8.max)
    self.init(white: w, alpha: a)
  }
  
}

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
  
  func removeTrackingAreas() {
    for area in trackingAreas {
      removeTrackingArea(area)
    }
  }
  
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
