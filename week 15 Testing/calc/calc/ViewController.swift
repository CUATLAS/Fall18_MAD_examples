
import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var inputField: UITextField!
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var doItButton: UIButton!
  @IBOutlet weak var doItEventuallyButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func doItButton_touchUpInside(_ sender: Any) {
    let answer = Calculator().performCalculation(input: inputField.text)
    outputLabel.text = answer
  }
  
  @IBAction func doItEventuallyButton_touchUpInside(_ sender: Any) {
    self.doItButton.isEnabled = false
    self.doItEventuallyButton.isEnabled = false
    self.inputField.isEnabled = false

    Calculator().performAsynchronousCalculation(input: inputField.text) { (answer) in
      self.doItButton.isEnabled = true
      self.doItEventuallyButton.isEnabled = true
      self.inputField.isEnabled = true
      self.outputLabel.text = answer
    }
    
    // Still Working!
  }
}

