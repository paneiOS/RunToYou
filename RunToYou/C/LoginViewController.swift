//
//  ViewController.swift
//  RunToYou
//
//  Created by Comong on 5/02/17.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
import RxKakaoSDKUser
import KakaoSDKUser

final class LoginViewController: UIViewController, StoryboardView {
    
    private let loginView = LoginView()
    var disposeBag = DisposeBag()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
    func bind(reactor: ViewReactor) {
        //Action
        
        //increaseButton.rx.tap //rxcocoa
        loginView.loginButton.rx.tap
        .map { Reactor.Action.login}
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        //State
        reactor.state.map { $0.loginResult }
            .subscribe(onNext: { result in
                switch result {
                case .success(let oauthToken):
                    print("Login success: \(oauthToken)")
                    self.kakaoGetUserInfo()
                    // Handle success
                case .failure(let error):
                    print("Login error: \(error)")
                    // Handle error
                case .none:
                    print("nothing")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func kakaoGetUserInfo() {
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ user in
                print("me() success.")

                //do something
                let userName = user.kakaoAccount?.name
                let userEmail = user.kakaoAccount?.email
                let userGender = user.kakaoAccount?.gender
                let userProfile = user.kakaoAccount?.profile?.profileImageUrl
                let userBirthYear = user.kakaoAccount?.birthyear

                let contentText =
                "user name : \(String(describing: userName))\n userEmail : \(String(describing: userEmail))\n userGender : \(String(describing: userGender)), userBirthYear : \(String(describing: userBirthYear))\n userProfile : \(String(describing: userProfile))"

                print("user - \(user)")

                //self.loginView.textField.text = contentText

            }, onFailure: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
