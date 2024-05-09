//
//  UIFontExtension.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/08.
//

import UIKit

extension UIFont {
    enum Family: String {
        case black, bold, light, medium, regular, thin
    }
    
    enum CustomFont {
        case notoSans
    }
    
    static func customFont(_ name: CustomFont, family: Family, size: CGFloat) -> UIFont {
        switch name {
        case .notoSans:
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
