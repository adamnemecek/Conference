
import AppKit

private let horizontalLabelMargin = CGFloat(12)
private let verticalLabelMargin = CGFloat(6)

class TextButton: NSView {
  
  let label = ComponentLabel()
  
  var onClick: (() -> Void)?
  
  init(title: String, color: NSColor) {
    super.init(frame: .zero)
    addSubview(label)
    translatesAutoresizingMaskIntoConstraints = false
    wantsLayer = true
    layer?.backgroundColor = color.cgColor
    layer?.cornerRadius = 4
    
    label.stringValue = title
    label.translatesAutoresizingMaskIntoConstraints = false
    label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
    label.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    label.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
    label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
}
