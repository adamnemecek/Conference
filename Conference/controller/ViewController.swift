
import AppKit

protocol ViewController: class {
  
  var view: NSView { get }
  weak var navigationController: NavigationController? { get set }
  
}
