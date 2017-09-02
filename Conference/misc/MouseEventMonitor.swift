
import AppKit

protocol MouseEventMonitorDelegate: class {
  
  func didMove()
  func didStopAfterTimeInterval()
  
}

class MouseEventMonitor {
  
  weak var delegate: MouseEventMonitorDelegate?
  
  func listenOnMouseStop(timeInterval: TimeInterval) {
    
    func ScheduledTimer() -> Timer {
      return Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { timer in
        self.delegate?.didStopAfterTimeInterval()
      }
    }
    
    var timer = ScheduledTimer()
    NSEvent.addLocalMonitorForEvents(matching: .mouseMoved) { event in
      self.delegate?.didMove()
      timer.invalidate()
      timer = ScheduledTimer()
      return event
    }
    NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { event in
      self.delegate?.didMove()
      timer.invalidate()
      timer = ScheduledTimer()
    }
  }
  
}
