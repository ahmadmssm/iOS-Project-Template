//
//  MyViewController.swift
//  ExamplesFeature
//
//  Created by Ahmad Mahmoud on 03/07/2021.
//

import UIKit
import MVVMModule
import ServicesModule

public class MyViewModel: AppViewModel {
    
}

public class MyViewController: NavigatableAppViewController<MyViewModel, ExamplesNavigatorProtocol> {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
