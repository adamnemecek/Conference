
import AppKit

private let horizontalLabelMargin = CGFloat(12)
private let verticalLabelMargin = CGFloat(6)

class TextButton: NSView {
  
  let label = ComponentLabel()
  
  var onClick: (() -> Void)?
  
  init(title: String, color: NSColor) {
    super.init(frame: .zero)
    addSubview(label)
    wantsLayer = true
    layer?.backgroundColor = color.cgColor
    layer?.cornerRadius = 4
    label.stringValue = title
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  override var intrinsicContentSize: NSSize {
    return label.intrinsicContentSize.inset(horizontal: horizontalLabelMargin, vertical: verticalLabelMargin)
  }
  
  override func layout() {
    super.layout()
    label.frame.origin = CGPoint(x: horizontalLabelMargin, y: verticalLabelMargin)
    label.frame.size = label.intrinsicContentSize
  }
  
}
