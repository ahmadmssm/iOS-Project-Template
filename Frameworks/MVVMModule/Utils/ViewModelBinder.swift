//
//  ViewModelBinder.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 29/06/2021.
//

import RxSwift
import CoreModule

public class ViewModelBinder {
    
    public static func bind(observableField: Observable<String>,
                            validator: Validatable,
                            doOnTypeAction: @escaping (_ text: String) -> Void,
                            doOnInvalidText: @escaping (_ validationError: ValidationError) -> Void,
                            skipsCount: Int = 1) -> Disposable {
        return observableField.do(onNext: { text in
            do {
                try validator.validate(text)
                doOnTypeAction(text)
            }
            catch {
                doOnInvalidText(error as! ValidationError)
            }
        }).subscribe()
    }
}
