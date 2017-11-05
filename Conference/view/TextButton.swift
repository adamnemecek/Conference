
import AppKit

private let horizontalLabelMargin = CGFloat(12)
private let verticalLabelMargin = CGFloat(6)
private let scaling = CGFloat(1.05)

class TextButton: NSView {
  
  var onClick: (() -> Void)?
  
  private let titleLayer = CATextLayer()
  
  init(title: String, color: NSColor) {
    super.init(frame: .zero)
    let rootLayer = CALayer()
    let midX = CAConstraint(attribute: .midX, relativeTo: "superlayer", attribute: .midX)
    let midY = CAConstraint(attribute: .midY, relativeTo: "superlayer", attribute: .midY)
    
    layer = rootLayer
    wantsLayer = true
    
    rootLayer.actions = nil
    rootLayer.backgroundColor = color.cgColor
    rootLayer.cornerRadius = 4
    rootLayer.layoutManager = CAConstraintLayoutManager()
    rootLayer.addSublayer(titleLayer)
    
    titleLayer.contentsScale = NSScreen.main!.backingScaleFactor * 2
    titleLayer.string = title
    titleLayer.font = NSFont.systemFont(ofSize: 0)
    titleLayer.fontSize = 18
    titleLayer.addConstraint(midX)
    titleLayer.addConstraint(midY)
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError()
  }
  
  override func mouseEntered(with event: NSEvent) {
    super.mouseEntered(with: event)
    layer?.movedAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    layer?.transform = CATransform3DMakeScale(scaling, scaling, 1)
    
  }
  
  override func mouseExited(with event: NSEvent) {
    super.mouseExited(with: event)
    layer?.movedAnchorPoint = CGPoint(x: 0.5, y: 0.5)
    layer?.transform = CATransform3DMakeScale(1, 1, 1)
  }
  
  override func updateTrackingAreas() {
    removeTrackingAreas()
    let options = [
      .mouseEnteredAndExited,
      .activeAlways
    ] as NSTrackingArea.Options
    let area = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
    addTrackingArea(area)
  }
  
}
