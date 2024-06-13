//
//  TeamCreateViewController.swift
//  RunToYou
//
//  Created by 23 09 on 6/4/24.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class TeamCreateViewController: UIViewController {
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
        btn.layer.borderColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2).cgColor
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
        btn.layer.borderColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.2).cgColor
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupLayout()
        view.backgroundColor = .white
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(teamCreateButton)
        view.addSubview(teamJoinButton)
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
