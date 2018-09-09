//
//  UIColorExtensions.swift
//  PhotoZnapp
//
//  Created by Behran Kankul on 31.08.2018.
//  Copyright © 2018 Be Mobile. All rights reserved.
//

import UIKit

extension UIColor {
    open class var navBarBg : UIColor {
        return UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
    }
    open class var followBg : UIColor {
        return UIColor(red:0.95, green:0.88, blue:0.09, alpha:1.0)
    }
    open class var followedBg : UIColor {
        return UIColor(red:0.80, green:0.84, blue:0.85, alpha:1.0)
        //TagColors.Purple.toUIColor()
    }
    open class var textFieldBorder:UIColor {
        return UIColor(red:0.80, green:0.84, blue:0.85, alpha:1.0)
    }
    open class var textFieldBorderSelected:UIColor {
        return UIColor(red:0.31, green:0.02, blue:0.96, alpha:1.0)
    }
    open class var btnSelectedBackground:UIColor {
        return UIColor(red:0.18, green:0.62, blue:0.75, alpha:1.0)
    }
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
            
        } else {
            return nil
        }
    }
}
