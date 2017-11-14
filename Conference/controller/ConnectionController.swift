
import AppKit

class ConnectionController: ViewController {
  
  let view = NSView()
  let connectionInput = TextInput()
  let connectButton = TextButton(title: "Connect", color: ColorGreen)
  let backButton = TextButton(title: "Back", color: ColorBlue)
  
  weak var navigationController: NavigationController?
  
  init() {
    let buttonStack = NSStackView()
    let stackHeight = connectionInput.intrinsicContentSize.height + 12 + connectButton.intrinsicContentSize.height + 12 + backButton.intrinsicContentSize.height
    
    view.addSubview(buttonStack)
    
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.orientation = .vertical
    buttonStack.distribution = .equalSpacing
    buttonStack.addArrangedSubview(connectionInput)
    buttonStack.addArrangedSubview(connectButton)
    buttonStack.addArrangedSubview(backButton)
    buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    buttonStack.widthAnchor.constraint(equalToConstant: 320).isActive = true
    buttonStack.heightAnchor.constraint(equalToConstant: stackHeight).isActive = true
    
    connectButton.onClick = {
      let videoSessionController = VideoSessionController()
    //  self.navigationController?.push(controller: videoSessionController, transition: .slide)
    }
    
    backButton.onClick = {
      self.navigationController?.pop(transition: .slide)
    }
    
    PassPhraseGenerator(wordCount: 4) { passPhrase in
      self.connectionInput.text = passPhrase
    }
  }
  
}
