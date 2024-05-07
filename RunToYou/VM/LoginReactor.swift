//
//  ViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 2024/04/25.
//

import UIKit
import ReactorKit
import KakaoSDKAuth
import KakaoSDKUser

final class LoginReactor: Reactor {
    weak var vcDelegate: UIViewController?
    var initialState: State = State()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    enum Action {
        case googleLogin
        case kakaoLogin
        case naverLogin
        case appleLogin
        case logout
    }
    
    enum Mutation {
        case setGoogleLoginResult(Result<OAuthToken, Error>)
        case setKaKaoLoginResult(Result<OAuthToken, Error>)
        case setNaverLoginResult(Result<OAuthToken, Error>)
        case setAppleLoginResult(Result<OAuthToken, Error>)
        case logout
    }
    
    struct State {
        var googleLoginResult: Result<OAuthToken, Error>?
        var kakaoLoginResult: Result<OAuthToken, Error>?
        var naverLoginResult: Result<OAuthToken, Error>?
        var appleLoginResult: Result<OAuthToken, Error>?
        var logout: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .googleLogin:
            return Observable.just(Mutation.logout)
        case .kakaoLogin:
                guard UserApi.isKakaoTalkLoginAvailable() else { return .empty() }
                        return UserApi.shared.rx.loginWithKakaoTalk()
                            .map { Mutation.setKaKaoLoginResult(.success($0)) }
                            .catch { error in
                                .just(.setKaKaoLoginResult(.failure(error)))
                                
                            }
        case .naverLogin:
            return Observable.just(Mutation.logout)
        case .appleLogin:
            return Observable.just(Mutation.logout)
        case .logout:
            return Observable.just(Mutation.logout)
        }
    }
                
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setGoogleLoginResult(let result):
            newState.googleLoginResult = result
            print("result:",result)
        case .setKaKaoLoginResult(let result):
            newState.kakaoLoginResult = result
            print("result:",result)
        case .setNaverLoginResult(let result):
            newState.naverLoginResult = result
            print("result:",result)
        case .setAppleLoginResult(let result):
            newState.appleLoginResult = result
            print("result:",result)
        case .logout:
            newState.logout = ""
        }
        return newState
    }
    
}
