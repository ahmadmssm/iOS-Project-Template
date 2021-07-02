//
//  UIImageView+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 22/02/2021.
//

import Nuke
import UIKit
import ResourcesModule

// UIImageView+ImageLoading
// Library: https://github.com/kean/Nuke
// Why this library and not KingFisher: https://www.hackingwithswift.com/forums/ios/must-have-pods-libraries/21/22
extension UIImageView: ImageLoadingService {}

public protocol ImageLoadingService {
    func loadImage(with url: URL?, fallbackImage: UIImage, color: UIColor?)
    func loadImage(with url: String?, fallbackImage: UIImage, color: UIColor?)
}

public extension ImageLoadingService where Self: UIImageView {
    
    func loadImage(with url: String?, fallbackImage: UIImage = #imageLiteral(resourceName: "image_fallback"), color: UIColor? = nil) {
        self.loadImage(with: url?.toURL(), fallbackImage: fallbackImage, color: color)
    }
    
    func loadImage(with url: URL?, fallbackImage: UIImage = #imageLiteral(resourceName: "image_fallback"), color: UIColor? = nil) {
        if(url != nil) {
            let options = ImageLoadingOptions(
                placeholder: fallbackImage,
                transition: .fadeIn(duration: 0.33)
            )
            Nuke.loadImage(with: url!, options: options, into: self) { _ in
                if(color != nil) {
                    self.image = self.setImageColor(color: color!)
                }
            }
        }
        else {
            self.image = fallbackImage
            self.layer.cornerRadius = self.frame.size.width / 2
        }
    }
    
    func setImageColor(color: UIColor) -> UIImage? {
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
        return image
    }
}
