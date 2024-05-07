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
import GoogleSignIn
import GoogleSignInSwift
import SnapKit

final class LoginViewController: UIViewController, StoryboardView {
    
    private let loginView = LoginView()
    var disposeBag = DisposeBag()
    let google = GIDSignInButton()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
    func bind(reactor: LoginReactor) {
        reactor.vcDelegate = self
        //Action
        loginView.googleButton.rx.tap
        .map { Reactor.Action.googleLogin}
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        loginView.kakaoButton.rx.tap
        .map { Reactor.Action.kakaoLogin}
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        loginView.naverButton.rx.tap
        .map { Reactor.Action.naverLogin}
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        loginView.appleButton.rx.tap
        .map { Reactor.Action.appleLogin}
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        //State
        reactor.state.map { $0.kakaoLoginResult }
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let oauthToken):
                    print("Login success: \(oauthToken)")
                    self?.kakaoGetUserInfo()
                    self?.goNextView()
                    // Handle success
                case .failure(let error):
                    print("Login error: \(error)")
                    // Handle error
                case .none:
                    print("nothing")
                }
            })
            .disposed(by: disposeBag)
        
        
        reactor.state.map { $0.googleLoginResult }
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let oauthToken):
                    print("Login success: \(oauthToken)")
                    //self?.kakaoGetUserInfo()
                    self?.goNextView()
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
    
    func goNextView() {
        let nextView = IntroduceViewController()
        nextView.reactor = IntroduceReactor()
        navigationController?.pushViewController(nextView, animated: true)
    }
}

extension LoginViewController {
    func handleSignInButton() {
      GIDSignIn.sharedInstance.signIn(
        withPresenting: self) { signInResult, error in
          guard let result = signInResult else {
            // Inspect error
            return
          }
          // If sign in succeeded, display the app's main content View.
        }
    }
    
    
}
