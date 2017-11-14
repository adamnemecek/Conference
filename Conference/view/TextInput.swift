
import AppKit

class TextInput: NSView {
  
  private let inputField = NSTextField()
  
  var text: String {
    get {
      return inputField.stringValue
    }
    set(value) {
      inputField.stringValue = value
    }
  }
  
  init() {
    super.init(frame: .zero)
    wantsLayer = true
    layer?.backgroundColor = ColorTextBackground.cgColor
    layer?.cornerRadius = 4
    addSubview(inputField)
    
    inputField.font = NSFont.systemFont(ofSize: 18)
    inputField.textColor = ColorText
    inputField.alignment = .center
    inputField.isBordered = false
    inputField.backgroundColor = .clear
    inputField.focusRingType = .none
    inputField.translatesAutoresizingMaskIntoConstraints = false
    inputField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    inputField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    inputField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  override var intrinsicContentSize: NSSize {
    return NSSize(width: NSView.noIntrinsicMetric, height: 32)
  }
    
}
