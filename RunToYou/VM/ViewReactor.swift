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

//Action.increase ->Observable( Mutation.increaseValue )-> State.value 형식으로 전달
final class ViewReactor: Reactor {
    var initialState: State = State()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    enum Action {
        case login
        case logout
    }
    
    enum Mutation {
        case setLoginResult(Result<OAuthToken, Error>)
        case logout
    }
    
    struct State {
        var loginResult: Result<OAuthToken, Error>?
        var logout: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .login:
                guard UserApi.isKakaoTalkLoginAvailable() else { return .empty() }
                        return UserApi.shared.rx.loginWithKakaoTalk()
                            .map { Mutation.setLoginResult(.success($0)) }
                            .catch { error in
                                .just(.setLoginResult(.failure(error)))
                                
                            }
        case .logout:
            return Observable.just(Mutation.logout)
        }
    }
                
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoginResult(let result):
            newState.loginResult = result
        case .logout:
            newState.logout = ""
        }
        return newState
    }
    
}
