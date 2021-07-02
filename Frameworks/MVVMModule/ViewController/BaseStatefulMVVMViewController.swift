//
//  BaseStatefulMVVMViewController.swift
//  SwiftLIveData
//
//  Created by Ahmad Mahmoud on 13/02/2021.
//

import UIKit

open class BaseStatefulMVVMViewController<VM: BaseStatefulViewModel>: BaseMVVMViewController<VM> {
    
    open override func attachViewModelObservers() {
        viewModel?.emitUponSubscribe(enabled: self.shouldEmitUponSubscribe())
        viewModel?.viewState.addObserve(observerOwner: self, observer: { viewState in
            self.renderView(for: viewState)
        })
    }
    
    open override func disconnectViewModelObservers() {
        self.viewModel?.viewState.removeObserver(observerOwner: self)
    }
    
    open func networkConnected() {}
    
    open func networkDisconnected() {}
    
    open func showLoading() {}
    
    open func hideLoading() {}
    
    open func forceLogOut() {}
    
    public func render(obj: Any) {}
    
    open func render(error: Error) {}
    
    public func renderCompleted() {}
    
    open func renderNoInternetConnectionError() {}
    
    open func show(errorMessage: String) {
        fatalError("Not Implemented")
    }
    
    // Get the latest changes upon listening to the ViewModel observable -> True
    // Get the updates only when a new value is pushed to the observable -> False
    open func shouldEmitUponSubscribe() -> Bool {
        return false
    }
    
    public func renderView(for state: ViewState) {
        DispatchQueue.main.async {
            switch state {
            case .showLoading:
                self.showLoading()
            case .hideLoading:
                self.hideLoading()
            case .online:
                self.networkConnected()
            case .offline:
                self.networkDisconnected()
            case .result(let obj):
                self.render(obj: obj)
            case .completedWithEmptyResult:
                self.renderCompleted()
            case .error(let error):
                self.render(error: error)
            }
        }
    }
}
