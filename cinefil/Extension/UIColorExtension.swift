//
//  UIColorExtension.swift
//  cinefil
//
//  Created by zhou on 2/16/16.
//  Copyright © 2016 zhou. All rights reserved.
//

import UIKit

extension UIColor {

    class func colorFromHex(hex: String) -> UIColor {
        return colorFromHex(hex, alpha: 1)
    }
    
    class func colorFromHex(hex: String, alpha: Float) -> UIColor {
        guard hex != "" else { return UIColor.clearColor() }

        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }

        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)

        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }

}
