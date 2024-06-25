//
//  CustomDropDown.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//

import UIKit

final class CustomDropDownTable: UITableView {
    // MARK: - Properties
    private let minHeight: CGFloat = 0
    private let maxHeight: CGFloat = 260
    // MARK: - Initializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        rowHeight = 50
        backgroundColor = .customColor(.mainGray)
        layer.cornerRadius = 11
        separatorStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        register(
            CustomDropDownCell.self,
            forCellReuseIdentifier: CustomDropDownCell.identifier
        )
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - override Layout Methods
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        if contentSize.height > maxHeight {
            return CGSize(width: contentSize.width, height: maxHeight)
        } else if contentSize.height < minHeight {
            return CGSize(width: contentSize.width, height: minHeight)
        } else {
            return contentSize
        }
    }
}

// MARK: - Internal Methods
extension CustomDropDownTable {
    func deselectAllCell() {
        self.visibleCells.forEach { $0.isSelected = false }
    }
    func selectRow(at indexPath: IndexPath) {
        deselectAllCell()
        (self.cellForRow(at: indexPath) as? CustomDropDownCell)?.isSelected = true
    }
}
