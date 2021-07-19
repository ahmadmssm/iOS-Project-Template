//
//  BaseMVVMViewController.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 13/02/2021.
//

import UIKit
import CoreModule

open class BaseMVVMViewController<VM: BaseViewModel>: UIViewController {
    
    public internal(set) var viewModel: VM?
    public private(set) var isObserving = false
    
    required public override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.setupViews()
        self.viewModel?.viewDidLoad()
        self.viewModel?.viewDidLoad(observableAttached: false)
        self.internalAttachViewModelObservers()
        self.viewModel?.viewDidLoad(observableAttached: true)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewWillAppear()
        if (!self.isObserving) {
            // To handle back action .. Re-observe when going back because we are removing the observers in viewDidDisappear.
            self.internalAttachViewModelObservers()
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.viewDidAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.viewWillDisappear()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel?.viewDidDisappear()
    }
    
    open func attachViewModelObservers() {}
    
    // Must call super when override
    open func disconnectViewModelObservers() {
        self.isObserving = false
    }
    
    open func setupViews() {}
    
    // I did this to avoid overriding it without calling super and to guarantee the order of execution.
    private func internalAttachViewModelObservers() {
        self.viewModel?.viewWillAttachObservable()
        self.isObserving = true
        self.attachViewModelObservers()
        self.viewModel?.viewDidAttachObservable()
    }
    
    deinit {
        self.disconnectViewModelObservers()
    }
    
    // This function to be used to initialise any ViewController instead of the default initialiser
    // There is no way that I know to make the default initialiser private and initialise it this way.
    public class func create(arg0: Any? = nil,
                             arg1: Any? = nil,
                             arg2: Any? = nil,
                             arg3: Any? = nil,
                             arg4: Any? = nil,
                             arg5: Any? = nil) -> Self {
        //
        let viewController = Self.create()
        viewController.viewModel = Resolver.optional(arg0: arg0,
                                                     arg1: arg1,
                                                     arg2: arg2,
                                                     arg3: arg3,
                                                     arg4: arg4,
                                                     arg5: arg5)
        return viewController
    }
    
    static func create() -> Self {
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: Self.self)
        return Self.init(nibName: nibName, bundle: bundle)
    }
}
