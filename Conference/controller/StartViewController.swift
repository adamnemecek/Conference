
import AppKit

class StartViewController {
  
  let view = NSView()
  
  private let createChannelButton = TextButton(title: "Create", color: ColorCyan)
  private let joinChannelButton = TextButton(title: "Join", color: ColorCyan)
  
  init() {
    let buttonStack = NSStackView()
    
    view.wantsLayer = true
    view.layer?.backgroundColor = NSColor.white.cgColor
    view.addSubview(buttonStack)
    
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.orientation = .vertical
    buttonStack.distribution = .fillEqually
    buttonStack.spacing = 12
    buttonStack.addArrangedSubview(createChannelButton)
    buttonStack.addArrangedSubview(joinChannelButton)
    buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    buttonStack.widthAnchor.constraint(equalToConstant: 300).isActive = true
    buttonStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
    
    createChannelButton.onClick = {
      
    }
    
    joinChannelButton.onClick = {
      
    }
  }
  
}
