//
//  NFXImageBodyDetailsController.swift
//  netfox
//
//  Copyright © 2016 netfox. All rights reserved.
//

#if os(iOS)
    
import Foundation
import UIKit

class NFXImageBodyDetailsController: NFXGenericBodyDetailsController {
    
    var dishImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image preview"
        self.dishImageView.frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 2*10, height: self.view.frame.height - 2*10)
        self.dishImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.dishImageView.contentMode = .scaleAspectFit
        let data = Data.init(base64Encoded: self.selectedModel.getResponseBody() as String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        self.dishImageView.image = UIImage(data: data!)
        self.view.addSubview(self.dishImageView)
    }
}

#endif
