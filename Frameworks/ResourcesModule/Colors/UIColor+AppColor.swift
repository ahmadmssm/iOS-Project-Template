//
//  UIColor+AppColor.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 21/02/2021.
//

import UIKit.UIColor

public extension UIColor {
    static var alert: UIColor { UIColor.appColor(.Alert) }
    static var alto: UIColor { UIColor.appColor(.Alto) }
    static var cottonCandy: UIColor { UIColor.appColor(.CottonCandy) }
    static var darkOrange: UIColor { UIColor.appColor(.DarkOrange) }
    static var doveGray: UIColor { UIColor.appColor(.DoveGray) }
    static var dustyGray: UIColor { UIColor.appColor(.DustyGray) }
    static var emerald: UIColor { UIColor.appColor(.Emerald) }
    static var error: UIColor { UIColor.appColor(.Error) }
    static var fontGray: UIColor { UIColor.appColor(.FontGray) }
    static var gallery: UIColor { UIColor.appColor(.Gallery) }
    static var gold: UIColor { UIColor.appColor(.Gold) }
    static var info: UIColor { UIColor.appColor(.Info) }
    static var lavender: UIColor { UIColor.appColor(.Lavender) }
    static var mineShaft: UIColor { UIColor.appColor(.MineShaft) }
    static var normalOrange: UIColor { UIColor.appColor(.NormalOrange) }
    static var pictonBlue: UIColor { UIColor.appColor(.PictonBlue) }
    static var silver: UIColor { UIColor.appColor(.Silver) }
    static var success: UIColor { UIColor.appColor(.Success) }
    static var transparentBlack: UIColor { UIColor.appColor(.TransparentBlack) }
}

extension UIColor {
    
    private enum ColorsKeys: String {
        case Alert
        case Alto
        case CottonCandy
        case DarkOrange
        case DoveGray
        case DustyGray
        case Emerald
        case Error
        case FontGray
        case Gallery
        case Gold
        case Info
        case Lavender
        case MineShaft
        case NormalOrange
        case PictonBlue
        case Silver
        case Success
        case TransparentBlack

        var name: String {
            self.rawValue
        }
    }
    
    private static func appColor(_ colorKey: ColorsKeys) -> UIColor {
        if let color = UIColor.init(named: colorKey.name, in: Bundle.resources, compatibleWith: nil) {
            return color
        }
        fatalError("Color with name \(colorKey) could not be resolved!")
    }
}
