//
//  CustomDropDown.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//
import UIKit

final class CustomDropDownCell: UITableViewCell {
    static let identifier = "Cell"
    override var isSelected: Bool {
        didSet {
            optionLabel.textColor = isSelected ? .black : .black
        }
    }
    // MARK: - UI Components
    private let optionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .customColor(.mainGray)
        setupUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - Configure
    func configure(with text: String) {
        optionLabel.text = text
    }
}

// MARK: - UI Methods
private extension CustomDropDownCell {
    func setupUI() {
        setViewHierarchy()
        setConstraints()
    }
    func setViewHierarchy() {
        contentView.addSubview(optionLabel)
    }
    func setConstraints() {
        optionLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
