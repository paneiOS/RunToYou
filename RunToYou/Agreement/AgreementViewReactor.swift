//
//  AgreementViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 5/29/24.
//
import UIKit
import ReactorKit

final class AgreementViewReactor: Reactor {
    enum Action {
        case agreeAll
        case agreeUseTerm
        case agreePrivacy
        case agreeAge
        case agreeHealth
        case agreeGps
        case agreeEvent
        case goNextPage
    }

    enum Mutation {
        case agreeAll
        case agreeUseTerm
        case agreePrivacy
        case agreeAge
        case agreeHealth
        case agreeGps
        case agreeEvent
    }

    struct State {
        var allChecked: Bool = false
        var termUseChecked: Bool = false
        var privacyChecked: Bool = false
        var ageChecked: Bool = false
        var healthChecked: Bool = false
        var gpsChecked: Bool = false
        var eventChecked: Bool = false
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .agreeAll:
            return .just(Mutation.agreeAll)
        case .agreeUseTerm:
            return .just(Mutation.agreeUseTerm)
        case .agreePrivacy:
            return .just(Mutation.agreePrivacy)
        case .agreeAge:
            return .just(Mutation.agreeAge)
        case .agreeHealth:
            return .just(Mutation.agreeHealth)
        case .agreeGps:
            return .just(Mutation.agreeGps)
        case .agreeEvent:
            return .just(Mutation.agreeEvent)
        case .goNextPage:
            return Observable.empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .agreeAll:
            newState.allChecked.toggle()
            newState.termUseChecked = newState.allChecked
            newState.privacyChecked = newState.allChecked
            newState.ageChecked = newState.allChecked
            newState.healthChecked = newState.allChecked
            newState.gpsChecked = newState.allChecked
            newState.eventChecked = newState.allChecked
        case .agreeUseTerm:
            newState.termUseChecked.toggle()
        case .agreePrivacy:
            newState.privacyChecked.toggle()
        case .agreeAge:
            newState.ageChecked.toggle()
        case .agreeHealth:
            newState.healthChecked.toggle()
        case .agreeGps:
            newState.gpsChecked.toggle()
        case .agreeEvent:
            newState.eventChecked.toggle()
        }
        return newState
    }
}
