//
//  UIColor+Extension.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hexString: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hexString >> 16) & 0xFF) / 255.0,
            green: CGFloat((hexString >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hexString & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}

