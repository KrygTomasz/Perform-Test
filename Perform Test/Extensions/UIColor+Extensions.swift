//
//  UIColor+Extensions.swift
//  Perform Test
//
//  Created by Kryg Tomasz on 25.11.2017.
//  Copyright © 2017 Kryg Tomasz. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public class var main: UIColor {
        return UIColor(hex: "#112D40")
    }
    
    public class var lightMain: UIColor {
        return UIColor(hex: "#19425E")
    }
    
    public class var tint: UIColor {
        return UIColor(hex: "#1D4D6E")
    }
    
    public class var text: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
}

