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
        case mainGray
    }

    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .mainDark:
            return UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        case .mainBlue:
            return UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1)
        case .mainRed:
            return UIColor(red: 242/255, green: 118/255, blue: 79/255, alpha: 1)
        case .mainGray:
            return UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        }
    }
}
