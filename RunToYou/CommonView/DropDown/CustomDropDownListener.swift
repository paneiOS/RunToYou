//
//  CustomDropDownListener.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//

import UIKit

protocol CustomDropDownListener: AnyObject {
    var dropDownViews: [CustomDropDownView]? { get set }

    func hit(at hitView: UIView?)
    func registerDropDrownViews(_ dropDownViews: CustomDropDownView...)
    func dropdown(_ dropDown: CustomDropDownView, didSelectRowAt indexPath: IndexPath)
}

extension CustomDropDownListener where Self: UIViewController {
    func registerDropDrownViews(_ dropDownViews: CustomDropDownView...) {
        self.dropDownViews = dropDownViews
        dropDownViews.forEach {
            $0.listener = self
            $0.anchorView?.isUserInteractionEnabled = true
        }
    }

    func hit(at hitView: UIView?) {
        guard let hitView = hitView else { return }

        dropDownViews?.forEach { view in
            if
                view.anchorView === hitView {
                view.isDisplayed.toggle()
            } else {
                view.isDisplayed = false
            }
        }
    }
}
