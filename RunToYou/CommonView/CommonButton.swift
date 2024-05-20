//
//  CommonButton.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/20.
//

import UIKit

final class CommonButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    private func setupButton() {
        backgroundColor = .customColor(.mainDark)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .customFont(.notoSans, family: .regular, size: 18)
        layer.cornerRadius = 8
    }

    func setupData(_ title: String?) {
        setTitle(title, for: .normal)
    }
}
