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
import NaverThirdPartyLogin
import Alamofire
import AuthenticationServices

final class LoginViewReactor: NSObject, Reactor {
    enum Action {
        case googleLogin
        case kakaoLogin
        case naverLogin
        case appleLogin
    }

    enum Mutation {
        case setGoogleLoginResult
        case setKaKaoLoginResult
        case setNaverLoginResult
        case setAppleLoginResult
    }

    struct State {
        var goNextPage: Bool = false
    }

    override init() {
        super.init()
        naverLoginInstance!.delegate = self
    }

    let initialState: State = State()
    weak var vcDelegate: UIViewController?
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let delegateLoginResultSubject = PublishSubject<Mutation>()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .googleLogin:
            return requestGoogleLogin()
        case .kakaoLogin:
            return requestKakaoLogin()
        case .naverLogin:
            return requestNaverLogin()
        case .appleLogin:
            return requestAppleLogin()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setGoogleLoginResult:
            newState.goNextPage = true
        case .setKaKaoLoginResult:
            newState.goNextPage = true
        case .setNaverLoginResult:
            newState.goNextPage = true
        case .setAppleLoginResult:
            newState.goNextPage = true
        }
        return newState
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation, delegateLoginResultSubject.asObservable())
    }

    private func requestGoogleLogin() -> Observable<Mutation> {
        return Observable.create { observer in
            guard let vcDelegate = self.vcDelegate else { return Disposables.create() }
            GIDSignIn.sharedInstance.signIn(
                withPresenting: vcDelegate) { signInResult, _ in
                    guard signInResult != nil else { return }
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

    private func requestNaverLogin() -> Observable<Mutation> {
        return Observable.create { observer in
            guard let vcDelegate = self.vcDelegate else { return Disposables.create() }
            GIDSignIn.sharedInstance.signIn(
                withPresenting: vcDelegate) { signInResult, _ in
                    guard signInResult != nil else { return }
                    observer.onNext(.setGoogleLoginResult)
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }

    private func requestAppleLogin() -> Observable<Mutation> {
        return Observable.create { _ in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider =
            self.vcDelegate as? ASAuthorizationControllerPresentationContextProviding
            authorizationController.performRequests()
            return Disposables.create()
        }
    }
}

extension LoginViewReactor: NaverThirdPartyLoginConnectionDelegate {
    // MARK: 로그인
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        delegateLoginResultSubject.onNext(.setNaverLoginResult)
    }
    // MARK: 토큰
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    }
    // MARK: 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
    }
    // MARK: 에러
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    }
}

extension LoginViewReactor: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        delegateLoginResultSubject.onNext(.setAppleLoginResult)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    }
}
