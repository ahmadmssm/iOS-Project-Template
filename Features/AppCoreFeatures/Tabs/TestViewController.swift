//
//  TestViewController.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 10/06/2021.
//

import UIKit.UIButton

public class TestViewController: CoreFeaturesViewController<TestViewModel> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func render(obj: Any) {
        super.render(obj: obj)
    }
    
    @IBAction private func action(_ sender: UIButton) {
        self.navigator?.openCoreDataExample(from: self)
    }
}
