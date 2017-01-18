//
//  Utils.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/17/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

extension String {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UITextField {
    static func create(at height: Int, borderStyle: UITextBorderStyle, view: UIView, text: String ) -> UITextField {
        let textfield = UITextField(frame: CGRect(x: 130, y: height, width: 97, height: 30))
        textfield.borderStyle = borderStyle
        textfield.text = text
        textfield.keyboardType = .decimalPad
        view.addSubview(textfield)
        return textfield
    }
}

extension UILabel {
    static func create (at height: Int, text: String, view: UIView) {
        let label = UILabel(frame: CGRect(x: 8, y: height, width: 120, height: 30))
        label.text = text
        view.addSubview(label)
    }
}

extension String {
    var toDouble: Double { return Double(self)! }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
}

