
import AppKit

class StartController {
  
  let view = NSView()
  let createChannelButton = TextButton(title: "Create", color: ColorCyan)
  let joinChannelButton = TextButton(title: "Join", color: ColorCyan)
  
  init() {
    view.addSubview(createChannelButton)
    view.addSubview(joinChannelButton)
  }
  
}

extension StartController: ViewController {
  
  func layoutSubviews() {
    createChannelButton.setPosition(x: 100, y: 200)
    joinChannelButton.setPosition(x: 100, y: 250)
  }
  
}
