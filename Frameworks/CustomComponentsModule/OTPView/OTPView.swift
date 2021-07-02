//
//  OTPView.swift
//  CustomComponentsModuleTests
//
//  Created by Ahmad Mahmoud on 27/02/2021.
//

import UIKit

public class OTPView: UIStackView, UITextFieldDelegate {
    
    public var boxWidth: CGFloat = 68
    public var font: UIFont?
    public var placeHolder = "-"
    public var numberOfDigits = 4
    public var boxCornerRadius: CGFloat = 20
    public var boxColor = UIColor.lightGray
    public var textColor = UIColor.black
    public weak var delegate: OTPViewDelegate?
    public var otpValue: String? {
        let sortedFields = self.textFieldArray.sorted { $0.tag < $1.tag }
        let values = sortedFields.compactMap { return $0.text }.filter { $0 != self.placeHolder }
        if(!values.isEmpty) {
            return values.joined(separator: "")
        }
        return nil
    }
    private var textFieldArray: [OTPTextField] = []
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func refresh() {
        self.configureStackView()
        self.configureTextFields()
    }
    
    private func configureStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
    }
    
    private func configureTextFields() {
        for index in 0..<numberOfDigits {
            let field = OTPTextField()
            field.tag = index
            field.delegate = self
            field.text = self.placeHolder
            field.textColor = self.textColor
            field.textAlignment = .center
            field.keyboardType = .numberPad
            field.keyboardAppearance = .dark
            field.backgroundColor = boxColor
            field.layer.cornerRadius = self.boxCornerRadius
            if(self.font != nil) {
                field.font = self.font
            }
            field.frame.size.width = self.boxWidth
            field.translatesAutoresizingMaskIntoConstraints = true
            field.widthAnchor.constraint(equalToConstant: self.boxWidth).isActive = true
            textFieldArray.append(field)
            addArrangedSubview(field)
            index != 0 ? (field.previousTextField = textFieldArray[index - 1]) : ()
            index != 0 ? (textFieldArray[index - 1].nextTextFiled = textFieldArray[index]) : ()
        }
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else { return true }
        if (!string.isEmpty && string != self.placeHolder) {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            if(field.nextTextFiled == nil && self.otpValue != nil) {
                self.delegate?.didFillOTP(self.otpValue!)
            }
            return true
        }
        else {
            self.delegate?.didRemoveOTP()
        }
        return true
    }
}
