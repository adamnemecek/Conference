
import AppKit

class StartViewController: ViewController {
  
  let view = NSView()
  weak var navigationController: NavigationController?
  
  private let createChannelButton = TextButton(title: "Create", color: ColorCyan)
  private let joinChannelButton = TextButton(title: "Join", color: ColorCyan)
  
  init() {
    let buttonStack = NSStackView()
    let stackHeight = createChannelButton.intrinsicContentSize.height + 12 + joinChannelButton.intrinsicContentSize.height
    
    view.addSubview(buttonStack)
    
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.orientation = .vertical
    buttonStack.distribution = .equalSpacing
    buttonStack.addArrangedSubview(createChannelButton)
    buttonStack.addArrangedSubview(joinChannelButton)
    buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    buttonStack.widthAnchor.constraint(equalToConstant: 320).isActive = true
    buttonStack.heightAnchor.constraint(equalToConstant: stackHeight).isActive = true
    
    createChannelButton.onClick = {
      let connectionController = ConnectionController()
      self.navigationController?.push(controller: connectionController, transition: .slide)
    }
    
    joinChannelButton.onClick = {
      
    }
  }
  
}
