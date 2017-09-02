
import AppKit

class ButtonComponent {
  
  let button: NSButton
  var onClick: (() -> Void)?
  
  var view: NSView {
    return button
  }
  
  init(title: String) {
    button = NSButton()
    button.bezelStyle = .roundRect
    button.title = title
    button.target = self
    button.action = #selector(onClickAction)
    button.translatesAutoresizingMaskIntoConstraints = false
  }
  
  @objc func onClickAction() {
    onClick?()
  }
  
}
