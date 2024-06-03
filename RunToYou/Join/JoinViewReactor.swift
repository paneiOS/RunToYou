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
        case inputNickName(String)
        case inputBirth(String)
        case selectYear(Int)
        case checkMale
        case checkFemale
        case checkNoComment
        case goNextPage
    }

    enum Mutation {
        case inputNickName(String)
        case inputBirth(String)
        case selectYear(Int)
        case checkMale
        case checkFemale
        case checkNoComment
        case goNextPage
    }

    struct State {
        var nickNameText: String = ""
        var birthText: String = ""
        var year: Int = 0
        var maleChecked: Bool = false
        var femaleChecked: Bool = false
        var noCommentChecked: Bool = false
        var isNextButtonEnabled: Bool = false
        var goNextPage: Bool = false
        var maleButtonImage: UIImage? {
             return maleChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase")
         }
         var femaleButtonImage: UIImage? {
             return femaleChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase")
         }
         var noCommentButtonImage: UIImage? {
             return noCommentChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase")
         }
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputNickName(let text):
            return .just(.inputNickName(text))
        case .inputBirth(let text):
            return .just(.inputBirth(text))
        case let .selectYear(index):
            return .just(.selectYear(index))
        case .checkMale:
            return .just(.checkMale)
        case .checkFemale:
            return .just(.checkFemale)
        case .checkNoComment:
            return .just(.checkNoComment)
        case .goNextPage:
            return .just(.goNextPage)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .inputNickName(let text):
            newState.birthText = text
        case .inputBirth(let text):
            newState.nickNameText = text
        case let .selectYear(year):
            newState.year = year
        case .checkMale:
            newState.maleChecked = state.maleChecked
            newState.maleChecked.toggle()
            newState.femaleChecked = false
            newState.noCommentChecked = false
        case .checkFemale:
            newState.femaleChecked = state.femaleChecked
            newState.femaleChecked.toggle()
            newState.maleChecked = false
            newState.noCommentChecked = false
        case .checkNoComment:
            newState.noCommentChecked = state.noCommentChecked
            newState.noCommentChecked.toggle()
            newState.maleChecked = false
            newState.femaleChecked = false
        case .goNextPage:
            newState.goNextPage = state.goNextPage
        }
        let isGenderSelected = newState.femaleChecked || newState.maleChecked || newState.noCommentChecked
        let isTextNotEmpty = !newState.nickNameText.isEmpty && !newState.birthText.isEmpty
        newState.isNextButtonEnabled = isTextNotEmpty && isGenderSelected
        return newState
    }
}
