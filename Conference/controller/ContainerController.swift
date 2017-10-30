
import AppKit

class ContainerController {
  
  let view: NSView
  var currentController: ViewController?
  
  init() {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func present(viewController: ViewController, transition: Transition) {
    currentController?.view.removeFromSuperview()
    view.addSubview(viewController.view)
    viewController.view.frame = view.bounds
    viewController.layoutSubviews()
    currentController = viewController
  }
  
}

extension ContainerController: ViewController {
  
  func layoutSubviews() {
    currentController?.view.frame = view.bounds
    currentController?.layoutSubviews()
  }
  
}

extension ContainerController {
  
  enum Transition {
  
    case none
    case forward
    case backward
    
  }
  
}
