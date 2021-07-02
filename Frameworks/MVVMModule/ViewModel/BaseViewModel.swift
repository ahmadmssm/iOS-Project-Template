//
//  BaseViewModel.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 12/02/2021.
//

import UIKit.UIViewController

open class BaseViewModel {

    public init() {}
    
    open func viewWillAttachObservable() {
        print("viewDidAttachObservable")
    }
    
    open func viewDidAttachObservable() {
        print("viewDidAttachObservable")
    }
        
    open func viewDidLoad(observableAttached: Bool) {
        print("viewDidLoad with observableAttached : \(observableAttached)")
    }
   
    open func viewDidLoad() {
        print("viewDidLoad")
    }
    
    open func viewWillAppear() {
        print("viewWillAppear")
    }
    
    open func viewDidAppear() {
        print("viewDidAppear")
    }
    
    open func viewWillDisappear() {
        print("viewWillDisappear")
    }
    
    open func viewDidDisappear() {
        print("viewDidDisappear")
    }
    
    private func print(_ items: Any...) {
        #if DEBUG
        Swift.print(items[0])
        #endif
    }
}
