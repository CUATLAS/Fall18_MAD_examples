
import Foundation

// This interface isolates the dependency
protocol Operation {
  func operate(input:Int) -> Int
}

// This is the actual implementation of the dependency
class SquareOperation: Operation {
  func operate(input:Int) -> Int {
    return input * input
  }
}


