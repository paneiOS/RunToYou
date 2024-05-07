//
//  ViewController.swift
//  RunToYou
//
//  Created by 이정환 on 4/22/24.
//
import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class IntroduceViewController: UIViewController, StoryboardView {

    private let introduceView = IntroduceView()
    var disposeBag = DisposeBag()
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = introduceView
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func bind(reactor: IntroduceReactor) {
        introduceView.nextButton.rx.tap
            .bind(onNext: { [weak self] in self?.goNextView() })
            .disposed(by: disposeBag)
    }
    
    func goNextView() {
        let nextView = LoginViewController()
        nextView.reactor = LoginReactor()
        navigationController?.pushViewController(nextView, animated: true)
    }

}
