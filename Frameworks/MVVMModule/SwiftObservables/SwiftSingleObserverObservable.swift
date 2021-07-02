//
//  SwiftSingleObserverObservable.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 12/02/2021.
//

/*
 Only one observer is allowed to listen for updates.
 If a new observer is added, then the previous observer will be removed first before adding the new one.
 */
class SwiftSingleObserverObservable<T>: SwiftObservable<T> {
    
    override func addObserve(observerOwner: ObserverOwner, observer: @escaping (T) -> Void) {
        self.removeAllObservers()
        super.addObserve(observerOwner: observerOwner, observer: observer)
    }
}
