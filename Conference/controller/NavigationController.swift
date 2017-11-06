
import AppKit

class NavigationController {
  
  let contentView = NSView()
  
  
  
  func present(view: NSView, transition: Transition) {
    contentView.addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
  
}

extension NavigationController {
  
  enum Transition {
  
    case none
    case forward
    case backward
    
  }
  
}
