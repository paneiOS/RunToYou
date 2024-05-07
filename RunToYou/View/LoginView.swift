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
import GoogleSignInSwift

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
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "LaunchScreen")
        return image
    }()
    
    let runToYouImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "launchLabel")
        return image
    }()
    
    let googleButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("구글로 로그인", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 16)
        btn.setImage(UIImage(named: "google"), for: .normal)
        btn.layer.cornerRadius = 7
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let kakaoButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("카카오 로그인", for: .normal)
        btn.backgroundColor = UIColor.getColor(hexString: "FEE500")
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 16)
        //원래 검은색이라 하이라이트 색깔 따로 넣어줌
        btn.setImage(UIImage(named: "kakao")?.withTintColor(.darkGray), for: .highlighted)
        btn.setImage(UIImage(named: "kakao"), for: .normal)
        btn.layer.cornerRadius = 7
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let naverButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("네이버 로그인", for: .normal)
        btn.backgroundColor = UIColor.getColor(hexString: "03C75A")
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 16)
        btn.setImage(UIImage(named: "naver"), for: .normal)
        btn.layer.cornerRadius = 7
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let appleButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("애플로 로그인", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 16)
        btn.setImage(UIImage(named: "apple"), for: .normal)
        btn.layer.cornerRadius = 7
        btn.layer.borderWidth = 1

        return btn
    }()
    
    lazy var loginBtnStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.addArrangedSubview(googleButton)
        sv.addArrangedSubview(kakaoButton)
        sv.addArrangedSubview(naverButton)
        sv.addArrangedSubview(appleButton)
        return sv
    }()
    
    

    func setupLayout() {
        self.backgroundColor = .white
        self.addSubview(backgroundImage)
        self.addSubview(runToYouImage)
        self.addSubview(loginBtnStackView)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        runToYouImage.snp.makeConstraints { make in
            make.bottom.equalTo(loginBtnStackView.snp.top).offset(-46)
            make.width.equalTo(248)
            make.height.equalTo(95)
            make.centerX.equalToSuperview()
        }
        
        loginBtnStackView.snp.makeConstraints { make in
            make.height.equalTo(243)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
            
        }
        
        googleButton.imageView!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        kakaoButton.imageView!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        naverButton.imageView!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        appleButton.imageView!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        

    

        

    }
    


}
