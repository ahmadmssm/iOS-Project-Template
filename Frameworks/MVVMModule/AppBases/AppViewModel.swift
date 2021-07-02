//
//  AppViewModel.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 23/02/2021.
//

import RxSwift
import CoreModule
import DataModule

open class AppViewModel: BaseStatefulViewModel {
    
    public lazy private(set) var disposer: Disposer? = {
        return Disposer()
    }()
    
    open func postShowLoadingState() {
        self.viewStateController?.postShowLoadingState()
    }
    
    open func post(error: Error) {
        self.viewStateController?.post(error: error)
    }
    
    open func noInternetErrorViewRetryButtonClicked() {}
    
    open func didTapUnKnownError() {}
    
    open func bindField(_ disposable: Disposable) {
        self.disposer?.add(disposable)
    }
    
    deinit {
        if(self.disposer != nil) {
            self.disposer = nil
        }
    }
}
