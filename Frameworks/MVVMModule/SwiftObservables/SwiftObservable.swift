//
//  SwiftObservable.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 09/02/2021.
//
// Ref: https://blog.engineering.publicissapient.fr/2020/06/15/swift-livedata/

/*
 
 SwiftObservable can initialized with or without value, If it is initialized with a default value, then this value will be emitted once a new observer is added.
 If it was intialized using the empty constructor, then no data will be emitted initially until a new value is set.
 
 */
class SwiftObservable<T> {
    
    typealias Observer = (T) -> Void
    typealias ObserverOwner = AnyObject
    /*
     We can’t store the observer directly into our observers array because
     it is going to be retained as a STRONG reference to the array (which is a struct),
     to solve this, I created a wrapper and I'm adding thes wrapper into the array
     instead of adding the closure itself to the array.
     */
    private class WeakObserverWrapper {
        var observer: Observer?
        var observerOwner: ObserverOwner?
    }
    // Emit the last result immediately when adding a listener
    private var shouldEmitUponObserving = false
    private var observers: [WeakObserverWrapper] = []
    private var value: T? {
        didSet {
            // Each time the data is set, we need to notify all registered observers as an Observer can have multiple listeners (observers).
            notifyObservers()
        }
    }
    
    init() {}
    
    init(_ value: T) {
        self.value = value
    }

    func addObserve(observerOwner: ObserverOwner, observer: @escaping (T) -> Void) {
        let observerWeakWrapper = WeakObserverWrapper()
        observerWeakWrapper.observer = observer
        observerWeakWrapper.observerOwner = observerOwner
        observers.append(observerWeakWrapper)
        if (self.shouldEmitUponObserving) {
            self.notify(observerWeakWrapper)
        }
    }
        
    func removeObserver(observerOwner: ObserverOwner) {
        observers.removeAll { $0.observerOwner != nil && $0.observerOwner === observerOwner }
    }
    
    func removeAllObservers() {
        observers.removeAll()
    }
    
    func setValue(_ value: T) {
        self.value = value
    }
    
    func enableEmitUponObserving() {
        self.shouldEmitUponObserving = true
    }
    
    func disableEmitUponObserving() {
        self.shouldEmitUponObserving = false
    }
    
    private func notifyObservers() {
        self.observers.forEach { notify($0) }
    }
    
    private func notify(_ observerWeakWrapper: WeakObserverWrapper) {
        guard let value = value else { return }
        observerWeakWrapper.observer?(value)
    }
}
