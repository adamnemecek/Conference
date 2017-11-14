
import AppKit

class NavigationController: ViewController {
  
  let view = NSView()
  weak var navigationController: NavigationController?
  
  private var layouts = [Layout]()
  private var controllers = [ViewController]()
  
  init() {
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.white.cgColor
  }
  
  func push(controller: ViewController, transition: Transition) {
    let currentLayout = layouts.last
    let layout = Layout(view: controller.view, container: view)
    
    controller.navigationController = self
    
    controllers.append(controller)
    layouts.append(layout)
    view.addSubview(controller.view)
    
    switch transition {
    case .none:
      layout.center()
    case .slide:
      view.animateConstraints(duration: Transition.slideDuration) {
        currentLayout?.left()
      }
      layout.right()
      view.animateConstraints(duration: Transition.slideDuration, delay: Transition.slideDelay) {
        layout.center()
      }
    }
    
  }
  
  func pop(transition: Transition) {
    guard let layout = layouts.popLast(), let nextLayout = layouts.last else {
      return
    }
    guard let controller = controllers.popLast(), let nextController = controllers.last else {
      return
    }
    
    switch transition {
    case .none:
      layout.center()
    case .slide:
      controller.view.animateConstraints(duration: Transition.slideDuration) {
        layout.right()
      }
      nextController.view.animateConstraints(duration: Transition.slideDuration, delay: Transition.slideDelay) {
        nextLayout.center()
      }
    }
  }
  
}

extension NavigationController {
  
  enum Transition {
    
    case none
    case slide
    
    static let slideDuration = TimeInterval(0.4)
    static let slideDelay = TimeInterval(0.3)
    
  }
  
  struct Layout {
    
    let width: NSLayoutConstraint
    let height: NSLayoutConstraint
    let leftOnLeft: NSLayoutConstraint
    let leftOnRight: NSLayoutConstraint
    let rightOnLeft: NSLayoutConstraint
    let centerY: NSLayoutConstraint
    
    init(view: NSView, container: NSView) {
      view.translatesAutoresizingMaskIntoConstraints = false
      width = view.widthAnchor.constraint(equalTo: container.widthAnchor)
      height = view.heightAnchor.constraint(equalTo: container.heightAnchor)
      leftOnLeft = view.leftAnchor.constraint(equalTo: container.leftAnchor)
      leftOnRight = view.leftAnchor.constraint(equalTo: container.rightAnchor)
      rightOnLeft = view.rightAnchor.constraint(equalTo: container.leftAnchor)
      centerY = view.centerYAnchor.constraint(equalTo: container.centerYAnchor)
    }
    
    func center() {
      let active = [
        width,
        height,
        leftOnLeft,
        centerY
      ]
      let inactive = [
        leftOnRight,
        rightOnLeft
      ]
      NSLayoutConstraint.activate(active)
      NSLayoutConstraint.deactivate(inactive)
    }
    
    func right() {
      let active = [
        width,
        height,
        leftOnRight,
        centerY
      ]
      let inactive = [
        leftOnLeft,
        rightOnLeft
      ]
      NSLayoutConstraint.activate(active)
      NSLayoutConstraint.deactivate(inactive)
    }
    
    func left() {
      let active = [
        width,
        height,
        rightOnLeft,
        centerY
      ]
      let inactive = [
        leftOnLeft,
        leftOnRight
      ]
      NSLayoutConstraint.activate(active)
      NSLayoutConstraint.deactivate(inactive)
    }
    
  }
  
}
