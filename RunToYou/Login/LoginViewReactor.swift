//
//  LoginViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/20.
//

import UIKit
import ReactorKit

final class LoginViewReactor: Reactor {
    enum Action {
    }

    enum Mutation {
    }

    struct State {
    }

    let initialState: State = State()

    deinit {
        print("\(type(of: self)): Deinited")
    }
}
