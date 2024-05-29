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
        titleLabel?.font = .customFont(.notoSans, family: .medium, size: 18)
        layer.cornerRadius = 8
    }

    func makeDisable() {
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        setTitleColor(UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.4), for: .normal)
        isEnabled = false
    }

    func makeEnable() {
        backgroundColor = .customColor(.mainDark)
        setTitleColor(.white, for: .normal)
        isEnabled = true
    }

    func setupData(_ title: String?) {
        setTitle(title, for: .normal)
    }
}
