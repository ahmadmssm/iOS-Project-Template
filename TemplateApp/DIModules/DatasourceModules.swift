//
//  DatasourceModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 07/03/2021.
//

import DataModule
import CoreModule

extension Resolver {
    static func registerDataSourcesModules() {
        register { UserDefaultsDatasource(simpleDataCachingService: resolve()) }
        register { UnManagedDatasource(serializationService: resolve()) }.scope(.application)
//        register {
//            LocalCartDatasource(context: resolve(),
//                                serializationService: resolve()) as CartDataSource
//        }.scope(.application)
    }
}
