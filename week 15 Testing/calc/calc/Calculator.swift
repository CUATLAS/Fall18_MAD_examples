
import Foundation

class Calculator {
  
  
  // DEPENDANCY INJECTION!!!
  var operation: Operation = SquareOperation()
  
  // This performs an operation synchronously
  func performCalculation( input:String? ) -> String? {
    // convert the string to an Int
    if let input = input, let intInput = Int(input) {
      return String(operation.operate(input: intInput))
    }
    // if anything failed, return nil
    return nil
  }
 
  // Old way before dependency injection
  /*
  // This performs an operation synchronously
  func performCalculation( input:String? ) -> String? {
    // convert the string to an Int
    if let input = input, let intInput = Int(input) {
      // return the output of the operation
      return String(SquareOperation().operate(input: intInput))
    }
    // if anything failed, return nil
    return nil
  }
  */
  
  // This performs an operation asynchronously
  func performAsynchronousCalculation( input:String?, callback: @escaping (String?)->() ) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      if let answer = self.performCalculation(input:input) {
        callback("Async: \(answer)")
      }
      else {
        callback(nil)
      }
    }
  }
  
}
