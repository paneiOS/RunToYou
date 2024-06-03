//
//  JoinViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 5/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class JoinViewReactor: Reactor {
    enum Action {
        case selectYear(Int)
        case checkMale
        case checkFemale
        case checkNoComment
    }

    enum Mutation {
        case selectYear(Int)
        case checkMale
        case checkFemale
        case checkNoComment
    }

    struct State {
        var year: Int = 0
        var maleChecked: Bool = false
        var femaleChecked: Bool = false
        var noCommentChecked: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .selectYear(index):
            return .just(.selectYear(index))
        case .checkMale:
            return .just(.checkMale)
        case .checkFemale:
            return .just(.checkFemale)
        case .checkNoComment:
            return .just(.checkNoComment)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .selectYear(year):
            newState.year = year
        case .checkMale:
            newState.maleChecked = state.maleChecked
            newState.maleChecked.toggle()
            newState.femaleChecked = false
            newState.noCommentChecked = false
            print("1")
        case .checkFemale:
            newState.femaleChecked = state.femaleChecked
            newState.femaleChecked.toggle()
            newState.maleChecked = false
            newState.noCommentChecked = false
            print("2")
        case .checkNoComment:
            newState.noCommentChecked = state.noCommentChecked
            newState.noCommentChecked.toggle()
            newState.maleChecked = false
            newState.femaleChecked = false
        }
        return newState
    }
}
