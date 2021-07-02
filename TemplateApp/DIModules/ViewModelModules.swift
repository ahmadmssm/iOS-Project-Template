//
//  ViewModelModules.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

import DataModule
import CoreModule
import AppCoreFeatures

extension Resolver {
    static func registerViewModelModules() {
        register { TestViewModel() }
    }
}
