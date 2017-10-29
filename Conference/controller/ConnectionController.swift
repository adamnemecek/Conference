
import AppKit

protocol ConnectionControllerDelegate: class {
  
  func didConnect()
  
}

class ConnectionController {
  
  let view: NSView
  let connectionInput = TextInput()
  let connectButton = Button()
  
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

<<<<<<< HEAD
    connectButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    connectButton.topAnchor.constraint(equalTo: inputView.bottomAnchor, constant: 20).isActive = true
    
    PassPhraseGenerator(wordCount: 4) { passPhrase in
      self.connectionInputViewComponent.inputField.stringValue = passPhrase
    }
=======
    connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    connectButton.topAnchor.constraint(equalTo: connectionInput.bottomAnchor, constant: 20).isActive = true
>>>>>>> a4398ed76cd816fb6a1c2d7046f0d0d982a3ef5a
  }
  
}
