//
//  LoginViewController.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/20.
//

import UIKit
import ReactorKit

final class LoginViewController: UIViewController {
    typealias Reactor = AppAuthViewReactor
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }
}
