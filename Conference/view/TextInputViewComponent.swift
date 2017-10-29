
import AppKit

class TextInputViewComponent {
  
  let view: NSView
  let inputField: NSTextField
  
  init() {
    view = NSView()
    inputField = NSTextField()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.wantsLayer = true
    view.layer?.backgroundColor = ColorTextBackground.cgColor
    view.layer?.cornerRadius = 4
    view.addSubview(inputField)
    
    inputField.font = NSFont.systemFont(ofSize: 24)
    inputField.textColor = ColorText
    inputField.alignment = .center
    inputField.isBordered = false
    inputField.backgroundColor = .clear
    inputField.focusRingType = .none
    inputField.translatesAutoresizingMaskIntoConstraints = false
    inputField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    inputField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    inputField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
}
