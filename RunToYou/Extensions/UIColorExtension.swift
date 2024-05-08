//
//  UIColorExtension.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/08.
//

import UIKit

extension UIColor {
    enum CustomColor {
        case mainDark
        case mainBlue
        case mainRed
    }
    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .mainDark:
            return getColor(hexString: "222222")
        case .mainBlue:
            return getColor(hexString: "4285F4")
        case .mainRed:
            return getColor(hexString: "F2764F")
        }
    }
    static func getColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
