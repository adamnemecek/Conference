
import AppKit

class TextButton: NSView {
  
  let label = NSTextField()
  
  var onClick: (() -> Void)?
  
  init(title: String, color: NSColor) {
    super.init(frame: .zero)
    wantsLayer = true
    layer?.backgroundColor = color.cgColor
    layer?.cornerRadius = 4
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  override var intrinsicContentSize: NSSize {
    return NSSize(width: 100, height: 24)
  }
  
  override func layout() {
    super.layout()
    print("layout")
  }
  
}
