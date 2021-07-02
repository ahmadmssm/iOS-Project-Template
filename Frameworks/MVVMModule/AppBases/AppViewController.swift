//
//  AppViewController.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 23/02/2021.
//

import UIKit
import CoreModule
import DataModule
import CustomComponentsModule

open class AppViewController<VM: AppViewModel>: BaseStatefulMVVMViewController<VM> {
    
    @LazyInjected private(set) var networkLoader: NetworkLoaderOverlay
    public private(set) lazy var noInternetConnectionView: ErrorView = {
        let errorView = ErrorView()
        errorView.apply {
            $0.set(icon: #imageLiteral(resourceName: "no_wifi"))
            $0.set(headerLabel: "something_went_wrong".localized)
            $0.set(infoLabel: "check_internet_connection".localized)
            $0.set(buttonLabel: "try_again".localized)
            $0.frame = self.view.bounds
            $0.buttonAction {
                self.noInternetErrorViewRetryButtonClicked()
            }
        }
        return errorView
    }()
    public private(set) lazy var unKnownErrorView: ErrorView = {
        let errorView = ErrorView()
        errorView.apply {
            $0.set(icon: #imageLiteral(resourceName: "icon-Info"))
            $0.set(headerLabel: "something_went_wrong".localized)
            $0.set(infoLabel: "unknown_error_message".localized)
            $0.set(buttonLabel: "reload_page".localized)
            $0.frame = self.view.bounds
            $0.buttonAction {
                self.unKnownErrorAction()
            }
        }
        return errorView
    }()
    
    open override func showLoading() {
        self.networkLoader.show()
    }
    
    open override func hideLoading() {
        self.networkLoader.hide()
    }
    
    open override func render(obj: Any) {
        self.hideNetworkLoaderAndErrorViews()
    }
    
    open override func render(error: Error) {
        self.hideNetworkLoaderAndErrorViews()
        if(error is NoInternetConnectionError) {
            self.renderNoInternetConnectionError()
        }
        else if (error is SessionExpiredError || error is RefreshTokenError) {
            self.forceLogOut()
        }
        else if (error is UnKnownError) {
            self.renderUnKnownError()
        }
        else if let formError = error as? FormError {
            self.render(formError.errors)
        }
        else if let simpleError = error as? SimpleError {
            self.show(errorMessage: simpleError.message)
        }
    }
    
    open override func renderNoInternetConnectionError() {
        self.view.addSubview(self.noInternetConnectionView)
    }
    
    open func render(_ formErrors: [String: String]) {
        fatalError("Not Implemented")
    }
    
    open func addNavigationBarBackButton() {
        let button = UIBarButtonItem(image: self.backButtonIcon(isRTL: UIApplication.isRTL),
                                     style: .plain,
                                     target: self, action: #selector(self.privateBackAction))
        button.tintColor = .white
        self.navigationItem.leftBarButtonItem = button
    }
    
    // Must call super
    open func hideNetworkLoaderAndErrorViews() {
        self.hideLoading()
        self.hideUnKnownError()
        self.hideNoInternetConnectionError()
    }
    
    open func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    open func tryCast<T>(listWrapper: Any?, completion: (ListWrapper<T>) -> Void) {
        if let wrapper = listWrapper as? ListWrapper<T> {
            completion(wrapper)
        }
    }
    
    open func tryCast<T>(obj: Any?, completion: (T) -> Void) {
        if let wrapper = obj as? T {
            completion(wrapper)
        }
    }
    
    open func tryCast<E: CustomState>(customState: Any?, completion: (E) -> Void) {
        if let wrapper = customState as? E {
            completion(wrapper)
        }
    }
    
    private func noInternetErrorViewRetryButtonClicked() {
        self.viewModel?.noInternetErrorViewRetryButtonClicked()
    }
    
    private func unKnownErrorAction() {
        self.viewModel?.didTapUnKnownError()
    }
    
    private func renderUnKnownError() {
        self.view.addSubview(self.unKnownErrorView)
    }
    
    private func hideUnKnownError() {
        self.unKnownErrorView.removeFromSuperview()
    }
    
    private func hideNoInternetConnectionError() {
        self.noInternetConnectionView.removeFromSuperview()
    }
    
    @objc private func privateBackAction() {
        self.backAction()
    }
}
