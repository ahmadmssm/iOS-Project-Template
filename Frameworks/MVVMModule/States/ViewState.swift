//
//  ViewState.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 13/02/2021.
//

public enum ViewState {
    case online
    case offline
    case showLoading
    case hideLoading
    case completedWithEmptyResult
    case result(Any)
    case error(Error)
}
