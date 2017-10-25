
import Foundation

func PrintExecutionTime(past: Date) {
  let executionTime = Date().timeIntervalSince(past) * 1000
  print(executionTime)
}
