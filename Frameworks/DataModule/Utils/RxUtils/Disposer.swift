//
//  Disposer.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 01/03/2021.
//

import RxSwift

// This class is just a wrapper around RxDisposeBag.
public class Disposer {
    
    private var disposeBag: DisposeBag? = {
        return DisposeBag()
    }()
    
    public init() {}
    
    public func add(_ disposable: Disposable) {
        self.disposeBag?.insert(disposable)
    }
    
    deinit {
        if(self.disposeBag != nil) {
            self.disposeBag = nil
        }
    }
}

public extension Disposable {
    func disposed(by disposer: Disposer?) {
        disposer?.add(self)
    }
}
