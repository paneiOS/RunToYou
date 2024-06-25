//
//  CustomDropDown.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//
import UIKit

class CustomDropDownCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            optionLabel.textColor = isSelected ? .black : .systemGray2
        }
    }

    // MARK: - UI Components
    private let optionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
}


