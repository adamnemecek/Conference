
import AppKit

class StartController {
  
  let view = NSView()
  let createChannelButton = TextButton(title: "Create", color: ColorCyan)
  let joinChannelButton = TextButton(title: "Join", color: ColorCyan)
  
  init() {
    view.addSubview(createChannelButton)
    view.addSubview(joinChannelButton)
    
    createChannelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    createChannelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10)
  }
  
}

extension StartController: ViewController {
  
  func layoutSubviews() {
    
  }
  
}
