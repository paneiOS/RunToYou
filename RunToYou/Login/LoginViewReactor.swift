//
//  LoginViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/20.
//

import UIKit
import ReactorKit
import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

final class LoginViewReactor: Reactor {
    enum Action {
        case googleLogin
        case kakaoLogin
    }

    enum Mutation {
        case setGoogleLoginResult
        case setKaKaoLoginResult
    }

    struct State {
        var goNextPage: Bool = false
    }

    let initialState: State = State()
    weak var vcDelegate: UIViewController?

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .googleLogin:
            return requestGoogleLogin()
        case .kakaoLogin:
            return requestKakaoLogin()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setGoogleLoginResult:
            newState.goNextPage = true
        case .setKaKaoLoginResult:
            newState.goNextPage = true
        }
        return newState
    }

    private func requestGoogleLogin() -> Observable<Mutation> {
        return Observable.create { observer in
            guard let vcDelegate = self.vcDelegate else { return Disposables.create() }
            GIDSignIn.sharedInstance.signIn(
                withPresenting: vcDelegate) { signInResult, _ in
                    guard let result = signInResult else { return }
                    observer.onNext(.setGoogleLoginResult)
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }

    private func requestKakaoLogin() -> Observable<Mutation> {
        guard UserApi.isKakaoTalkLoginAvailable() else { return .empty() }
        return UserApi.shared.rx.loginWithKakaoTalk()
            .map { _ in .setKaKaoLoginResult }
    }
}
