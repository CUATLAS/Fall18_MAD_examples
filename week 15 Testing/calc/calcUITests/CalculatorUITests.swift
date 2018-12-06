
import XCTest

class CalculatorUITests: XCTestCase {

  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.

      // In UI tests it is usually best to stop immediately when a failure occurs.
      continueAfterFailure = false

      // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
      XCUIApplication().launch()

      // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
    
  }
  
  func testFunction() {
    let app = XCUIApplication()
    app.textFields["textField"].tap()
    app.textFields["textField"].typeText("10")
    app.buttons["doItButton"].tap()

    XCTAssert(app.staticTexts.element(matching:.any, identifier: "answerLabel").label == "100")

    app.textFields["textField"].tap()
    app.textFields["textField"].clearAndEnterText(text: "5")
    app.buttons["doItButton"].tap()
    
    XCTAssert(app.staticTexts.element(matching:.any, identifier: "answerLabel").label == "25")
  }


}


