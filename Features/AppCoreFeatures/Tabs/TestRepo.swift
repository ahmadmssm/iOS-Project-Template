//
//  TestRepo.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 10/06/2021.
//

import DataModule
import MVVMModule

public class TestRepo: AppRepo {
    
    private let requestExecuter: RxRequestExecuterProtocol
    
    public init(requestExecuter: RxRequestExecuterProtocol) {
        self.requestExecuter = requestExecuter
    }
}
