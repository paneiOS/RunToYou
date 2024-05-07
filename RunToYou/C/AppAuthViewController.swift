//
//  AppAuthViewController.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/02.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class AppAuthViewController: UIViewController, StoryboardView {

    private let appAuthView = AppAuthView()
    var disposeBag = DisposeBag()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = appAuthView

    }
    
    func bind(reactor: AuthReactor) {
        appAuthView.nextButton.rx.tap
            .bind(onNext: { [weak self] in self?.goNextView() })
            .disposed(by: disposeBag)
    }
    
    func goNextView() {
        let nextView = IntroduceViewController()
        nextView.reactor = IntroduceReactor()
        navigationController?.pushViewController(nextView, animated: true)
    }

}
