
import AppKit

protocol ConnectionControllerDelegate: class {
  
  func didConnect()
  
}

class ConnectionController {
  
  let contentView: NSView
  let connectionInputViewComponent: TextInputViewComponent
  let connectButtonComponent: ButtonComponent
  
  weak var delegate: ConnectionControllerDelegate?
  
  init() {
    contentView = NSView()
    connectionInputViewComponent = TextInputViewComponent()
    connectButtonComponent = ButtonComponent(title: "Connect")
    let inputView = connectionInputViewComponent.view
    let connectButton = connectButtonComponent.view
    contentView.addSubview(inputView)
    contentView.addSubview(connectButton)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    connectButtonComponent.onClick = {
      self.delegate?.didConnect()
    }
    inputView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
    inputView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    inputView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
    inputView.heightAnchor.constraint(equalToConstant: 44).isActive = true

    connectButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    connectButton.topAnchor.constraint(equalTo: inputView.bottomAnchor, constant: 20).isActive = true
    
    PassPhraseGenerator(wordCount: 4) { passPhrase in
      self.connectionInputViewComponent.inputField.stringValue = passPhrase
    }
  }
  
}
