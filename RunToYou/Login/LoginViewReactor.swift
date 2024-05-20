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

final class LoginViewReactor: Reactor {
    enum Action {
        case kakaoLogin
    }

    enum Mutation {
        case setKaKaoLoginResult(Result<OAuthToken, Error>)
    }

    struct State {
        var goNextPage: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .kakaoLogin:
            guard UserApi.isKakaoTalkLoginAvailable() else { return .empty() }
                    return UserApi.shared.rx.loginWithKakaoTalk()
                .map { Mutation.setKaKaoLoginResult(.success($0)) }
                .catch { .just(.setKaKaoLoginResult(.failure($0))) }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setKaKaoLoginResult(let result):
            if case .success = result {
                newState.goNextPage = true
            } else {
                newState.goNextPage = false
            }
        }
        return newState
    }
}
