
import AppKit

class ContainerController {
  
  let contentView: NSView
  var childView: NSView?
  
  init() {
    contentView = NSView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func present(view: NSView) {
    childView?.removeFromSuperview()
    childView?.removeConstraints()
    contentView.addSubview(view)
    view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    childView = view
  }
  
}
