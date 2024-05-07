//
//  IntroduceView.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/03.
//

import UIKit

class IntroduceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Run to you는 단순히 달리기가 아닌 \n가족, 친구들과의 건강을\n확인하기 위한 앱이에요"
        label.numberOfLines = 3
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 20)
        return label
    }()

    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = UIColor.customColor(.MainDark)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 18)
        btn.layer.cornerRadius = 7
        return btn
    }()
    
    func setupLayout() {
        self.backgroundColor = .white
        self.addSubview(mainLabel)
        self.addSubview(nextButton)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(112)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        
    }

}
