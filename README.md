# CalculatorApp
[\[패스트캠퍼스\]](https://fastcampus.co.kr/courese/205949/clips/) 30개 프로젝트로 배우는 iOS 앱 개발 with Swift 초격차 패키지 Online

강의를 학습하며 배운 내용을 복습하며 정리하는 글입니다.

> Part. Basic 3. 계산기 앱 만들기

## MVC Model

아이폰의 기본 계산기 앱의 디자인 따라하며 작업하였고, 하나의 화면만 전달하기 때문에 MVC모델로 하나의 ViewController를 사용하였습니다.

#### 연산자 열거형

일반적인 계산기를 구현하기 위해서는 사칙연산이 필요합니다.

따라서 사칙연산을 하는 연산자 함수를 만들기 전에 가독성을 위해 연산자 데이터를 열거형으로 정의 했습니다.

```
// 연산자 열거형
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}
```

#### 기본 변수 선언

계산화는 과정에서 여러개의 값들을 저장하고 있어야 하기에 기본 변수를 선언해주는 과정입니다.

```
// 값 변수 선언
var displayNumber: String = ""
var firstOperand: String = ""
var secondOperand: String = ""
var result = ""

// 연산자 값 변수 선언
var currentOperation: Operation = .unknown
```

displayNumber은 화면에 숫자를 알려주는 변수이며 firstOpeand와 secondOperand는 연산하기 전 첫번째 수와 두번째 수를 담는 변수입니다. result는 결과 값 변수, currentOperation은 Operation의 열거형의 연산자 데이터를 가져오는 변수 입니다.

변수들에 들어가는 데이터의 흐름은 사칙연순 구현에서 다루겠습니다.

#### 연산자 함수

연산자 함수에는 더하기(Add), 빼기(Subtract), 곱하기(Multiply), 나누기(Divide)가 있습니다.

연산자 함수의 논리적인 흐름은 다음과 같습니다.

1.  사용자가 숫자 버튼을 누르면 숫자 버튼에 해당하는 숫자를 입력창에 추가합니다.
2.  사용자가 연산자 버튼을 누르면 현재까지 입력된 숫자를 가져와서 임시로 저장합니다.
3.  다시 숫자 버튼을 눌러 새로운 숫자를 입력합니다.
4.  다시 연산자 버튼을 눌러 이전에 저장한 숫자와 새로 입력된 숫자를 연산합니다.
5.  이전에 저장한 숫자와 연산 결과를 입력창에 표시합니다.

위의 논리적인 흐름을 바탕으로 Swift로 계산기의 연산자 함수를 구현할 수 있습니다.

구현한 코드는 다음과 같습니다.

```
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
```

구현한 소스코드를 예시를 들어 설명해 보겠습니다.

예) 20 + 30 = 을 계산한다고 가정 할 때

1\. 20을 입력하고 + 버튼을 눌렀을 때

currentOperation은 초기값 unknown 이라서 첫 번째 if-else 구문에서 else로 넘어가게 됩니다.

else구문을 넘어가게 되어 firstOperand에 displayNumber값인 20, currentOperation은 Add가 저장되고 displayNumber는 초기화 됩니다.

2\. 30과 연산자버튼(등호포함)이 입력된다고 가정 할 때

currentOperation은 Add가 저장되어있기 때문에 `if self.currentOperation != .unknown`구문으로 넘어가게 됩니다.

secondOperand에 displayNumber값인 30이 저장되고, displayNumber는 초기화 됩니다.

Double타입인 firstOperand와 secondOperand에 String타입인 firstOpeand와 secondOperand 값이 넘어가고 Add 연산을 하고 result에 저장합니다.

그 후 result값을 firstOperand에 저장하며 화면 Label에 뿌려준다. 마지막으로 2번째 연산자 버튼의 값을 currentOperation에 저장합니다.

#### IBAction Button 정리

```
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
```

\[ + \], \[ - \], \[ \* \], \[ / \], \[ = \]연산자 버튼은 operation 함수를 사용하고 currentOperation 값을 넘김으로서 연산을 수행하게 하였다.

\[ = \] 버튼은 전에 사용했던 currentOperation을 넘겨준다.

추가로 구현한 기능은 \[ 숫자 \], \[ AC \], \[ +/- \], \[ % \], \[ . \] 가 있습니다.

```
// MARK: - IBAction NummberButton

@IBAction func tapNumberButton(_ sender: UIButton) {
    guard let numberValue = sender.titleLabel?.text else { return }
    if self.displayNumber.count < 9 {
        self.displayNumber += numberValue
        self.numberOutputLabel.text = self.displayNumber
    }
}
```

\[ 숫자 \] 버튼은 1부터 9까지의 숫자 버튼이랑 연결 하였습니다.

1\. 숫자버튼이 눌러지면 numberValue에 눌러진 버튼의 titleLabel의 text값을 저장합니다.

2\. 숫자는 9개까지만 저장할 수 있게 displayNumber.count가 9보다 작을 때만 숫자를 저장하게 하였고

3\. 숫자가 들어올 때 마다 displayNumber에 값을 저장하고, 화면(numberOutputLabel.text)에 나오게 displayNumber값을 넘겨주었습니다.

```
// MARK: - IBAtion [AC]Button

@IBAction func tapClearButton(_ sender: UIButton) {
    self.displayNumber = ""
    self.firstOperand = ""
    self.secondOperand = ""
    self.result = ""
    self.currentOperation = .unknown
    self.numberOutputLabel.text = "0"
}
```

\[ AC \] 버튼은 초기화 버튼 입니다.

AC 버튼을 누르게 되면 모든 값들이 초기화 됩니다.

```
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
```

\[ +/- \] 버튼은 양수는 음수로 음수는 양수로 바꿔주는 버튼 입니다.

1\. +/- 버튼을 눌렀을 때 양수 또는 0일 때 displayNumber값이 없으면 -0으로 displayNumber값이 있으면 저장된 값 앞에 -를 붙이고 화면에 뿌려줍니다.

2\. 음수 또는 -0일 때는 compoents의 특성을 이용하여 "-"를 없애고 화면에 뿌려줍니다.

```
// MARK: - IBAtion [%]Button

@IBAction func tapPercentButton(_ sender: UIButton) {
    if !self.displayNumber.isEmpty {
        guard let percentOperand = Double(self.displayNumber) else { return }
        self.result = "\(percentOperand * 0.01)"
        self.displayNumber = self.result
        self.numberOutputLabel.text = self.displayNumber
    }
}
```

\[ % \] 버튼은 퍼센트 버튼 입니다.

% 버튼을 눌렀을 때 displayNumber값이 없으면 동작하지 않고, 값이 있을 경우 0.01을 곱하여 퍼센트로 만들어 줍니다. 

```
// MARK: - IBAtion [.]Button

@IBAction func tapDotButton(_ sender: UIButton) {
    if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
        self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
        self.numberOutputLabel.text = self.displayNumber
    }
}
```

\[ . \] 버튼은 소수점 버튼 입니다.

. 버튼을 눌렀을 때 displayNumber의 수가 8자리를 넘지 않고, 소수점이 없을 때 displayNumber가 없으면 0.1을 주고 있으면 displayNumber값 뒤에 .을 붙여줍니다.
