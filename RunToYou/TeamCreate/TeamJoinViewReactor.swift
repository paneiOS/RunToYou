//
//  TeamJoinViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 6/26/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class TeamJoinViewReactor: Reactor {
    enum Action {
        case inputInviteCode(code: String?)
    }

    enum Mutation {
        case inputInviteCode(code: String?)
    }

    struct State {
        var inviteCode: String?
        var isNext: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputInviteCode(code: let code):
            return .just(.inputInviteCode(code: code))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .inputInviteCode(code: let code):
            newState.inviteCode = code
            if let inviteCode = newState.inviteCode {
                newState.isNext = inviteCode.isEmpty ? false : true
            }
        }
        return newState
    }
}
