//
//  UITextField+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 09/04/2021.
//

import UIKit.UITextField

public extension UITextField {
    
    // Enable next keyboard button for every field except the last one which will be done action.
    static func connectFields(_ fields: UITextField...) {
        guard let last = fields.last else { return }
        // To reset the targets in case you call this method again to change the connected fields
        fields.forEach { $0.removeTarget(nil, action: nil, for: .editingDidEndOnExit) }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i + 1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .continue
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    @IBInspectable var localizedLabel: String {
        get {
            return self.localizedLabel
        } set {
            let newValue = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            self.placeholder = newValue.localized
        }
    }
}
