
import AppKit

protocol ConnectionControllerDelegate: class {
  
  func didConnect()
  
}

class ConnectionController {
  
  let view: NSView
  let connectionInput = TextInput()
  let connectButton = TextButton(title: "Connect", color: ColorGreen)
  
  weak var delegate: ConnectionControllerDelegate?
  
  init() {
    view = NSView()
    view.addSubview(connectionInput)
    view.addSubview(connectButton)
    view.translatesAutoresizingMaskIntoConstraints = false
    connectButton.onClick = {
      self.delegate?.didConnect()
    }
    connectionInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    connectionInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    connectionInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    connectionInput.heightAnchor.constraint(equalToConstant: 44).isActive = true

    connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    connectButton.topAnchor.constraint(equalTo: connectionInput.bottomAnchor, constant: 20).isActive = true
    
    PassPhraseGenerator(wordCount: 4) { passPhrase in
      self.connectionInput.inputField.stringValue = passPhrase
    }
  }
  
}
