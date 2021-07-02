//
//  Rx+BindableFields.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 29/06/2021.
//

import RxCocoa
import RxSwift
import UIKit.UITextField

public extension UITextField {
    func bindable() -> Observable<String> {
        return self.rx.controlEvent(.editingChanged).withLatestFrom(self.rx.text.orEmpty)
    }
}
