//
//  TeamJoinViewController.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//

import UIKit
import SnapKit
import ReactorKit

class TeamJoinViewController: UIViewController, View {
    private let titleLabel = {
        let label = UILabel()
        label.text = "기존의 팀에 가입하시는군요!\n런투유와 함께 즐겁게 달려보세요."
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 20)
        return label
    }()

    private let inviteCodeLabel = {
        let label = UILabel()
        label.text = "초대코드"
        label.textAlignment = .left
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private let inviteCodeTextField = {
        let textField = CommonTextField()
        return textField
    }()

    private let startButton = {
        let btn = CommonButton()
        btn.makeDisable()
        btn.setTitle("시작하기", for: .normal)
        return btn
    }()
    
    typealias Reactor = TeamJoinViewReactor
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = TeamJoinViewReactor()
        setupLayout()
    }

    func bind(reactor: TeamJoinViewReactor) {
        // 시작하기 버튼 탭 화면 이동
        startButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.goNextPage()
            })
            .disposed(by: disposeBag)

        // 초대코드 바인딩
        inviteCodeTextField.rx.text
            .map { Reactor.Action.inputInviteCode(code: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // 시작하기 버튼 활성/비활성화
        reactor.state.map { $0.isNext }
            .subscribe(onNext: { [weak self] isNext in
                guard let self = self else { return }
                if isNext {
                    self.startButton.makeEnable()
                } else {
                    self.startButton.makeDisable()
                }
            })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.backgroundColor = .white
        setupNavi()
        addSubviews()
        setupConstraints()
    }

    private func setupNavi() {
        self.title = "팀만들기"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white
        appearance.titleTextAttributes = [.font: UIFont.customFont(.notoSans, family: .medium, size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func addSubviews() {
        let subviews = [
            titleLabel,
            inviteCodeLabel,
            inviteCodeTextField,
            startButton
        ]
        subviews.forEach(view.addSubview)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        inviteCodeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(55)
        }

        inviteCodeTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(inviteCodeLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
        }

        startButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    // TODO: 홈화면 이동
    private func goNextPage() {
    }
}
