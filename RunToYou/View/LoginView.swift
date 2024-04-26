//
//  LoginView.swift
//  RunToYou
//
//  Created by 23 09 on 2024/04/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class LoginView: UIView {
    
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
    
    let loginButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("카카오 로그인", for: .normal)
        bt.backgroundColor = .yellow
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()

    func setupLayout() {
        self.backgroundColor = .white
        self.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    


}
