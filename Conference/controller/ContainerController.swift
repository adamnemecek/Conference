
import AppKit

class ContainerController {
  
  let view: NSView
  var childView: NSView?
  
  init() {
    view = NSView()
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func present(contentView: NSView, transition: Transition) {
    childView?.removeFromSuperview()
    childView?.removeConstraints()
    view.addSubview(contentView)
    contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    childView = view
  }
  
}

extension ContainerController {
  
  enum Transition {
  
    case none
    case forward
    case backward
    
  }
  
}
