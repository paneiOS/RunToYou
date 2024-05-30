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
        case naverColor
        case kakaoColor
    }

    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .mainDark:
            return UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        case .mainBlue:
            return UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1)
        case .mainRed:
            return UIColor(red: 242/255, green: 118/255, blue: 79/255, alpha: 1)
        case .naverColor:
            return UIColor(red: 3/255, green: 199/255, blue: 90/255, alpha: 1)
        case .kakaoColor:
            return UIColor(red: 254/255, green: 229/255, blue: 0/255, alpha: 1)
        }
    }
}
