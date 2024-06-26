//
//  CommonTextField.swift
//  RunToYou
//
//  Created by 23 09 on 5/30/24.
//

import UIKit

final class CommonTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    private func setupTextField() {
        backgroundColor = .customColor(.mainGray)
        layer.cornerRadius = 11
        font = .customFont(.notoSans, family: .regular, size: 16)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19))
    }
}
