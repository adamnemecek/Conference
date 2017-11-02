
import AppKit

func ComponentLabel() -> NSTextField {
  let textField = NSTextField()
  textField.font = NSFont.systemFont(ofSize: 16)
  textField.backgroundColor = .clear
  textField.isBordered = false
  textField.textColor = .white
  textField.isEditable = false
  return textField
}

