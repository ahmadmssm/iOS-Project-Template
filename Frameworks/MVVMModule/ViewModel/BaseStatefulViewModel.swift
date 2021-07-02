//
//  BaseStatefulViewModel.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 13/02/2021.
//

open class BaseStatefulViewModel: BaseViewModel {
    
    let viewState = SwiftSingleObserverObservable<ViewState>()
    //
    public private(set) lazy var viewStateController: ViewStateController? = {
        return ViewStateController(viewState: viewState)
    }()
    
    func emitUponSubscribe(enabled: Bool) {
        if(enabled) {
            self.viewState.enableEmitUponObserving()
        }
        else {
            self.viewState.disableEmitUponObserving()
        }
    }
}
