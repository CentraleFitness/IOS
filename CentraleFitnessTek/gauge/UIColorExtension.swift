//
//  SFGaugeView.swift
//  Pods
//
//  Created by Bruno Lima on 21/09/17.
//
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    
    func lighterColor() -> UIColor {
        let lighterColor    = CIColor.init(color: self)
        let red             = lighterColor.red
        let green           = lighterColor.green
        let blue            = lighterColor.blue
        let alpha           = lighterColor.alpha
        
        let lighterStep: CGFloat = 0.25
        
        return UIColor(red: min(red+lighterStep, 1.0), green: min(green+lighterStep, 1), blue: min(blue+lighterStep, 1), alpha: alpha)
    }
    
}
