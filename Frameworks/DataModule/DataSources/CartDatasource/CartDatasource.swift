//
//  CartDatasource.swift
//  DataModule
//
//  Created by Ahmad Mahmoud on 12/04/2021.
//

import RxSwift

public protocol CartDataSource {
    func flush() -> Completable
}
