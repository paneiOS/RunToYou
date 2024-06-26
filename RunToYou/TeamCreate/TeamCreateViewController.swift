//
//  TeamCreateViewController.swift
//  RunToYou
//
//  Created by 23 09 on 6/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class TeamCreateViewController: UIViewController, View {
    private var buttonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.imagePadding = 20
        config.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        return config
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "혹시 초대를 받으셨나요?\n런투유에서는 팀장이 되거나\n기존의 팀에 가입할 수 있어요."
        label.font = .customFont(.notoSans, family: .regular, size: 20)
        label.textAlignment = .left
        return label
    }()
    private lazy var teamCreateButton: UIButton = {
        let btn = UIButton(type: .system)
        buttonConfig.image = .person
        buttonConfig.title = "팀 만들기"
        btn.configuration = buttonConfig
        btn.layer.cornerRadius = 20
        btn.contentHorizontalAlignment = .leading
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
        return btn
    }()

    private lazy var teamJoinButton: UIButton = {
        let btn = UIButton(type: .system)
        buttonConfig.image = .team
        buttonConfig.title = "팀 참여하기"
        btn.configuration = buttonConfig
        btn.layer.cornerRadius = 20
        btn.contentHorizontalAlignment = .leading
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CGColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2)
        return btn
    }()

    private let nextButton: CommonButton = {
        let btn = CommonButton()
        btn.setupData("다음")
        btn.makeDisable()
        return btn
    }()

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupLayout()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reactor = TeamCreateViewReactor()
        self.nextButton.makeDisable()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func bind(reactor: TeamCreateViewReactor) {
        teamCreateButton.rx.tap
            .map { Reactor.Action.createTeam }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        teamJoinButton.rx.tap
            .map { Reactor.Action.joinTeam }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .map { Reactor.Action.goNextPage }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.createButtonColor }
            .observe(on: MainScheduler.instance)
            .bind(to: teamCreateButton.layer.rx.borderColor)
            .disposed(by: disposeBag)

        reactor.state.map { $0.joinButtonColor }
            .observe(on: MainScheduler.instance)
            .bind(to: teamJoinButton.layer.rx.borderColor)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isNextButtonEnable }
            .filter { $0 }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in
                self?.nextButton.makeEnable()
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.goNextPage }
            .distinctUntilChanged()
            .withLatestFrom(reactor.state.map { $0.nextPage })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] nextPage in
                guard let self = self else { return }
                switch nextPage {
                case .createTeamPage:
                    self.goNextPage(nextPage: TeamCreateDetailViewController())
                case .joinTeamPage:
                    self.goNextPage(nextPage: TeamJoinViewController())
                case .none:
                    break
                }
        })
        .disposed(by: disposeBag)
    }

    private func goNextPage(nextPage: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(nextPage, animated: true)
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(teamCreateButton)
        view.addSubview(teamJoinButton)
        view.addSubview(nextButton)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        teamCreateButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        teamJoinButton.snp.makeConstraints {
            $0.top.equalTo(teamCreateButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
         }
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
}
