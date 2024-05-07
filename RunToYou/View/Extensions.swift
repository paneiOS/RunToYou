//
//  ViewExtensions.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/02.
//

import UIKit

// MARK: - 폰트 extension
extension UIFont {
    
    enum Family: String {
        case Black, Bold, Light, Medium, Regular, Thin
    }
    
    enum CustomFont {
        case NotoSans
    }
    
    static func customFont(_ name: CustomFont, family: Family, size: CGFloat) -> UIFont {
        switch name {
        case .NotoSans:
            return UIFont(name: "NotoSansKR-\(family)", size: size)!
        }
        
    }
    
    static func attributedTextWithTwoFonts(text1: String, font1: UIFont, text2: String, font2: UIFont) -> NSAttributedString {
    
        
        // 첫 번째 텍스트와 폰트 설정
        let attributedText1 = NSAttributedString(string: text1, attributes: [.font: font1])
        let attributedString = NSMutableAttributedString(attributedString: attributedText1)
        
        // 두 번째 텍스트와 폰트 설정
        let attributedText2 = NSAttributedString(string: text2, attributes: [.font: font2])
        attributedString.append(attributedText2)
        
        return attributedString
    }
}

// MARK: - 컬러 extension
extension UIColor {
    enum CustomColor {
        case MainDark
        case MainBlue
        case MainRed
    }
   
    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .MainDark:
            return getColor(hexString: "222222")
        case .MainBlue:
            return getColor(hexString: "4285F4")
        case .MainRed:
            return getColor(hexString: "F2764F")
        }
    }
    
    static func getColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor  {
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
