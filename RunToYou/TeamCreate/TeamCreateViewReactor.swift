//
//  TeamCreateViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 6/13/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class TeamCreateViewReactor: Reactor {
    enum NextPage {
        case createTeamPage
        case joinTeamPage
    }
    enum Action {
        case createTeam
        case joinTeam
        case goNextPage
    }

    enum Mutation {
        case createTeam
        case joinTeam
        case goNextPage
    }

    struct State {
        var createButtonColor: CGColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
        var joinButtonColor: CGColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
        var isNextButtonEnable: Bool = false
        var selectedPage: NextPage = .createTeamPage
        var nextPage: NextPage?
        var goNextPage: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .createTeam:
            return .just(.createTeam)
        case .joinTeam:
            return .just(.joinTeam)
        case .goNextPage:
            return .just(.goNextPage)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .createTeam:
            newState.createButtonColor = UIColor.customColor(.mainBlue).cgColor
            newState.joinButtonColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
            newState.selectedPage = .createTeamPage
            newState.isNextButtonEnable = true
            newState.nextPage = .createTeamPage
        case .joinTeam:
            newState.joinButtonColor = UIColor.customColor(.mainBlue).cgColor
            newState.createButtonColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
            newState.selectedPage = .joinTeamPage
            newState.isNextButtonEnable = true
            newState.nextPage = .joinTeamPage
        case .goNextPage:
            newState.goNextPage.toggle()
        }
        return newState
    }
}
