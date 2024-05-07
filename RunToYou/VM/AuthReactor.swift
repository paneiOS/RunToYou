//
//  AuthReactor.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/03.
//

import UIKit
import ReactorKit

final class AuthReactor: Reactor {
    var initialState: State = State()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    enum Action {
        case nextButtonTapped
    }
    enum Mutation {
        case goNextScreen
    }
    
    struct State {
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonTapped:
            return Observable.just(Mutation.goNextScreen)
        }
    }
                
    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        switch mutation {
        case .goNextScreen:
            break
        }
        return newState
    }
}
