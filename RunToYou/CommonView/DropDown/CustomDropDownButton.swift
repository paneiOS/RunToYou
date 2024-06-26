//
//  CustomDropDownButton.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - DropDownTextMode
enum DropDownTextMode {
    case title
    case option
}

final class CustomDropDownButton: UIView {
    // MARK: - Properties
    var textMode: DropDownTextMode = .title {
        didSet {
            switch textMode {
            case .title:
                label.textColor = .systemGray2
            case .option:
                label.textColor = .black
            }
        }
    }

    // MARK: - UI Components
    private let label = UILabel()
    private let downImage = UIImageView(
        image: UIImage(systemName: "chevron.down")
    )

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1.2
        self.layer.borderColor = UIColor.black.cgColor

        setupUI()
    }

    convenience init(title: String?, option: DropDownTextMode) {
        self.init()
        setTitle(title, for: option)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - UI Methods
private extension CustomDropDownButton {
    func setupUI() {
        setViewHierarchy()
        setConstraints()
    }

    func setViewHierarchy() {
        addSubview(label)
        addSubview(downImage)
    }

    func setConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }

        downImage.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}

// MARK: - Internel Methods
extension CustomDropDownButton {
    func setTitle(_ title: String?, for mode: DropDownTextMode) {
        self.textMode = mode
        self.label.text = title
    }
}

// MARK: - Reactive Extension
extension Reactive where Base: CustomDropDownButton {
    var title: Binder<(title: String?, mode: DropDownTextMode)> {
        return Binder(self.base) { button, arguments in
            button.setTitle(arguments.title, for: arguments.mode)
        }
    }
}
