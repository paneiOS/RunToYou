//
//  TeamCreateDetailViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 6/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class TeamCreateDetailViewReactor: Reactor {
    enum Action {
        case selectGoalStep(steps: String?)
        case createTeamName(text: String?)
    }

    enum Mutation {
        case selectGoalStep(steps: String?)
        case createTeamName(text: String?)
    }

    struct State {
        let items = [
            "3,000 걸음",
            "5,000 걸음",
            "10,000 걸음",
            "15,000 걸음",
            "20,000 걸음"
        ]
        var selectedItem: String?
        var teamName: String?
        var isNext: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectGoalStep(let steps):
            return .just(.selectGoalStep(steps: steps))
        case .createTeamName(text: let text):
            return .just(.createTeamName(text: text))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .selectGoalStep(let steps):
            newState.selectedItem = steps
        case .createTeamName(text: let text):
            newState.teamName = text
        }
        return newState
    }

    func transform(state: Observable<State>) -> Observable<State> {
        return state.flatMap { state -> Observable<State> in
            var newState = state
            let isNext = (state.teamName?.isEmpty == false) && (state.selectedItem?.isEmpty == false)
            newState.isNext = isNext
            return Observable.just(newState)
        }
    }
}
