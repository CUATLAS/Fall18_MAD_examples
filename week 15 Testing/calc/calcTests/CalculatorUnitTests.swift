
import XCTest

class CalculatorUnitTests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInvalidInput() {
    let c = Calculator()
    let result = c.performCalculation(input: "Frodo Baggins")
    XCTAssert(result==nil,"invalid input should result in a nil response")
  }

  func testWhatItDoes() {
    let c = Calculator()
    let returnValue = c.performCalculation(input: "10")
    
    // It should give us back something that is non-nil
    guard let resultString = returnValue else {
      XCTFail("Valid input should result in a non-nil response")
      return
    }
    
    // It should give us back something that is an integer
    guard let resultInt = Int(resultString) else {
      XCTFail("All valid responses should be Integers")
      return
    }
    
    // It should give us a specific result of 100
    XCTAssert(resultInt==100,"Failed to calculate the correct result for 10.  Expected: 100 Actual: \(resultInt) ")
  }
  
  func testResults() {
    testResultValue(input: 10,result: 100)
    testResultValue(input: 1,result: 1)
    testResultValue(input: 0,result: 0)
    testResultValue(input: 50,result: 2500)
  }

  private func testResultValue( input: Int, result: Int) {
    let c = Calculator()
    let returnValue = c.performCalculation(input: String(input))
    
    guard let resultString = returnValue else {
      XCTFail("Valid input should result in a non-nil response")
      return
    }
    
    guard let resultInt = Int(resultString) else {
      XCTFail("All valid responses should be Integers")
      return
    }
    
    XCTAssert(resultInt==result,"Failed to calculate the correct result for \(input).  Expected: \(result) Actual: \(resultInt) ")
  }

  // This is a mocked implementation of the dependency
  class MockOperation: Operation {
    func operate(input:Int) -> Int {
      if input == 20 {
        return 20
      }
      else {
        return 100
      }
    }
  }
  
  func testDependency() {
    let c = Calculator()
    c.operation = MockOperation()
    
    let result = c.performCalculation(input: "20")
    XCTAssert(result=="20","Failed to calculate the mocked result for 20.  Expected: 20 Actual: \(result ?? "") ")
    
    let result2 = c.performCalculation(input: "0")
    XCTAssert(result2=="100","Failed to calculate the mocked result for 0.  Expected: 100 Actual: \(result ?? "") ")
  }
  
  func testAsynchronousResult() {
    
    let verifyNil = expectation(description: "Nil value received")
    
    Calculator().performAsynchronousCalculation(input: "Bilbo Baggins") { (answer) in
      if answer == nil {
        verifyNil.fulfill()
      }
    }
    
    waitForExpectations(timeout: 5.0) { (error) in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
    
  }

  func testAsyncWithInverted() {
    
    let gotNil = expectation(description: "Nil value received")
    gotNil.isInverted = true
    
    let valueCorrect = expectation(description: "Appropriate Value received")

    Calculator().performAsynchronousCalculation(input: "10") { (answer) in
      guard let nonNilAnswer = answer else {
        gotNil.fulfill()
        return
      }
      
      if nonNilAnswer == "Async: 100" {
        valueCorrect.fulfill()
      }
    }
    
    waitForExpectations(timeout: 5.0) { (error) in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
    
  }

}
