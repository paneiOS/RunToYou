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
            return UIColor(red: 34, green: 34, blue: 34, alpha: 1)
        case .mainBlue:
            return UIColor(red: 66, green: 133, blue: 244, alpha: 1)
        case .mainRed:
            return UIColor(red: 242, green: 118, blue: 79, alpha: 1)
        }
    }
}
