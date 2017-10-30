
import AppKit

protocol ViewController {
  
  var view: NSView { get }
  
  func layoutSubviews()
  
}
