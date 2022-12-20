//
//  RoundButton.swift
//  Calculator
//
//  Created by Jamong on 2022/12/20.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
   @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
