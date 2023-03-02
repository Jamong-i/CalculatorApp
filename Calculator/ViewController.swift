import UIKit

// MARK: - Operation 열거형

enum Operation {
	case Add
	case Subtract
	case Divide
	case Multiply
	case unknown
}


class ViewController: UIViewController {
	
	@IBOutlet weak var numberOutputLabel: UILabel!
	
	// 값 변수 저장
	var displayNumber: String = ""
	var firstOperand: String = ""
	var secondOperand: String = ""
	var result = ""
	// 연산자 값 변수 저장
	var currentOperation: Operation = .unknown
	
	// MARK: - ViewDidLoad
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - IBAction NummberButton
	
	@IBAction func tapNumberButton(_ sender: UIButton) {
		guard let numberValue = sender.titleLabel?.text else { return }
		if self.displayNumber.count < 9 {
			self.displayNumber += numberValue
			self.numberOutputLabel.text = self.displayNumber
		}
	}
	
	// MARK: - IBAtion [AC]Button
	
	@IBAction func tapClearButton(_ sender: UIButton) {
		self.displayNumber = ""
		self.firstOperand = ""
		self.secondOperand = ""
		self.result = ""
		self.currentOperation = .unknown
		self.numberOutputLabel.text = "0"
	}
	
	// MARK: - IBAtion [+/-]Button
	
	@IBAction func tapPostiveToNegativeButton(_ sender: UIButton) {
		if !self.displayNumber.contains("-") {
			if self.displayNumber.isEmpty {
				self.displayNumber = "-0"
				self.numberOutputLabel.text = displayNumber
			} else if !self.displayNumber.isEmpty {
				self.displayNumber = "-" + self.displayNumber
				self.numberOutputLabel.text = displayNumber
			}
		} else if self.displayNumber.contains("-") {
			self.displayNumber = self.displayNumber.components(separatedBy: ["-"]).joined()
			self.numberOutputLabel.text = self.displayNumber
		}
	}
	
	// MARK: - IBAtion [%]Button
	
	@IBAction func tapPercentButton(_ sender: UIButton) {
		if !self.displayNumber.isEmpty {
			guard let percentOperand = Double(self.displayNumber) else { return }
			self.result = "\(percentOperand * 0.01)"
			self.displayNumber = self.result
			self.numberOutputLabel.text = self.displayNumber
		}
	}
	
	// MARK: - IBAtion [.]Button
	
	@IBAction func tapDotButton(_ sender: UIButton) {
		if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
			self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
			self.numberOutputLabel.text = self.displayNumber
		}
	}
	
	// MARK: - IBAtion [/]Button
	
	@IBAction func tapDivideButton(_ sender: UIButton) {
		self.operation(.Divide)
	}
	
	// MARK: - IBAtion [*]Button
	
	@IBAction func tapMultiplyButton(_ sender: UIButton) {
		self.operation(.Multiply)
	}
	
	// MARK: - IBAtion [-]Button
	
	@IBAction func tapSubtractButton(_ sender: UIButton) {
		self.operation(.Subtract)
	}
	
	// MARK: - IBAtion [+]Button
	
	@IBAction func tapAddButton(_ sender: UIButton) {
		self.operation(.Add)
	}
	
	// MARK: - IBAtion [=]Button
	
	@IBAction func tapEqualButton(_ sender: UIButton) {
		self.operation(self.currentOperation)
	}
	
	// MARK: - Operation Function
	
	func operation(_ operation: Operation) {
		if self.currentOperation != .unknown {
			if !self.displayNumber.isEmpty {
				self.secondOperand = self.displayNumber
				self.displayNumber = ""
				
				guard let firstOperand = Double(self.firstOperand) else { return }
				guard let secondOperand = Double(self.secondOperand) else { return }
				
				switch self.currentOperation {
				case .Add:
					self.result = "\(firstOperand + secondOperand)"
				
				case .Subtract:
					self.result = "\(firstOperand + secondOperand)"
					
				case .Multiply:
					self.result = "\(firstOperand * secondOperand)"
					
				case .Divide:
					self.result = "\(firstOperand / secondOperand)"
					
				default:
					break
				}
				
				if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
					self.result = "\(Int(result))"
				}
				
				self.firstOperand = result
				self.numberOutputLabel.text = self.result
			}
			
			self.currentOperation = operation
		} else {
			self.firstOperand = self.displayNumber
			self.currentOperation = operation
			self.displayNumber = ""
		}
	}
}

