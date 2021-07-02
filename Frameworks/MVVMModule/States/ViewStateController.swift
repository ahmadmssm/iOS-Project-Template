//
//  ViewStateController.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 13/02/2021.
//

import Foundation

public class ViewStateController {
    
    private let viewState: SwiftSingleObserverObservable<ViewState>
    
    init(viewState: SwiftSingleObserverObservable<ViewState>) {
        self.viewState = viewState
    }
    
    // To be used to post custom types of ViewState such as screen related states
    public func post(viewState: ViewState) {
        self.viewState.setValue(viewState)
    }
    
    public func post<T>(obj: T) {
        self.post(viewState: .result(obj))
    }
    
    public func post<T>(list: [T], type: T.Type, reloadFromScratch: Bool = false) {
        // When we want to remove the old list and submit a new one
        if(reloadFromScratch) {
            self.post(listWrapper: ListWrapper<T>.reloadListFromScratch(list: list))
        }
        else {
            if(list.isEmpty) {
                self.post(listWrapper: ListWrapper<T>.emptyList)
            }
            else {
                self.post(listWrapper: .list(list))
            }
        }
    }
    
    public func post(error: Error) {
        self.post(viewState: .error(error))
    }
    
    public func postShowLoadingState() {
        self.post(viewState: .showLoading)
    }
    
    public func postHideLoadingState() {
        self.post(viewState: .hideLoading)
    }
    
    public func postCompletedState() {
        self.post(viewState: .completedWithEmptyResult)
    }
    
    private func post<T>(listWrapper: ListWrapper<T>) {
        self.post(viewState: .result(listWrapper))
    }
}
