//
//  OTPTextField.swift
//  CustomComponentsModuleTests
//
//  Created by Ahmad Mahmoud on 27/02/2021.
//

import UIKit

class OTPTextField: UITextField {
    
    var nextTextFiled: UITextField?
    var previousTextField: UITextField?
    
    override func deleteBackward() {
        text = "-"
        previousTextField?.becomeFirstResponder()
    }
}
