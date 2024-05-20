//
//  LoginViewController.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/20.
//

import UIKit
import ReactorKit

final class LoginViewController: UIViewController {
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = .luanchScreen
        return image
    }()

    private let runToYouImage: UIImageView = {
        let image = UIImageView()
        image.image = .launchLabel
        return image
    }()

    private let googleButton: LoginButton = {
        let btn = LoginButton(configuration: .plain())
        btn.setupData(
            title: "구글로 로그인",
            titleColor: .black,
            bgColor: .white,
            icon: .google
        )
        return btn
    }()

    private let kakaoButton: LoginButton = {
        let btn = LoginButton(configuration: .plain())
        btn.setupData(
            title: "카카오 로그인",
            titleColor: .black,
            bgColor: .customColor(.kakaoColor),
            icon: .kakao
        )
        return btn
    }()

    private let naverButton: LoginButton = {
        let btn = LoginButton(configuration: .filled())
        btn.setupData(
            title: "네이버 로그인",
            titleColor: .white,
            bgColor: .customColor(.naverColor),
            icon: .naver
        )
        return btn
    }()

    private let appleButton: LoginButton = {
        let btn = LoginButton(configuration: .plain())
        btn.setupData(
            title: "애플로 로그인",
            titleColor: .white,
            bgColor: .black,
            icon: .apple
        )
        return btn
    }()

    typealias Reactor = AppAuthViewReactor
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(backgroundImage)
        self.view.addSubview(runToYouImage)
        self.view.addSubview(googleButton)
        self.view.addSubview(kakaoButton)
        self.view.addSubview(naverButton)
        self.view.addSubview(appleButton)

        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        googleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(500)
        }

        kakaoButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(googleButton.snp.bottom).offset(8)
        }

        naverButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(kakaoButton.snp.bottom).offset(8)
        }

        appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(naverButton.snp.bottom).offset(8)
        }
    }
}

final class LoginButton: UIButton {
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
        titleLabel?.font = .customFont(.notoSans, family: .regular, size: 16)
        layer.borderWidth = 1
        layer.cornerRadius = 8
        configuration?.background.cornerRadius = 8
    }

    func setupData(title: String?, titleColor: UIColor?, bgColor: UIColor?, icon: UIImage?) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        tintColor = titleColor
        backgroundColor = bgColor
        configuration?.image = icon
        configuration?.baseBackgroundColor = bgColor
        // 데이터 셋업하고 난 다음에 설정해야 함
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
        guard let image = imageView else { return }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
