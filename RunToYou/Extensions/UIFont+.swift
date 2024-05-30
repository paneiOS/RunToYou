//
//  UIFontExtension.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/08.
//

import UIKit

extension UIFont {
    enum Family: String {
        case black, bold = "Thin_Bold", light, medium, regular, thin
    }

    enum CustomFont {
        case notoSans
    }

    static func customFont(_ name: CustomFont, family: Family, size: CGFloat) -> UIFont {
        switch name {
        case .notoSans:
            return UIFont(name: "NotoSansKR-\(family.rawValue)", size: size)!
        }
    }
}
