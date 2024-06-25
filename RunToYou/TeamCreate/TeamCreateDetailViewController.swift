//
//  TeamCreateDetailViewController.swift
//  RunToYou
//
//  Created by 23 09 on 6/24/24.
//

import UIKit
import SnapKit
import RxSwift

final class TeamCreateDetailViewController: UIViewController, CustomDropDownListener {
    var dropDownViews: [CustomDropDownView]?

    func dropdown(_ dropDown: CustomDropDownView, didSelectRowAt indexPath: IndexPath) {

    }

    private var buttonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .customColor(.mainGray)
        config.baseForegroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.4)
        config.image = .arrowDown
        config.title = "목표 걸음수를 설정해주세요"
        return config
    }()

    private let titleLabel = {
        let label = UILabel()
        label.text = "새로운 팀을 만들고\n함께 할 친구들을 초대해보세요."
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 20)
        return label
    }()

    private let teamNameLabel = {
        let label = UILabel()
        label.text = "팀 이름"
        label.textAlignment = .left
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private let teamNameDiscriptionLabel = {
        let label = UILabel()
        label.text = "(팀 이름은 팀에 가입하기 전까진 남들이 알 수 없어요)"
        label.textColor = .init(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.4)
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 12)
        return label
    }()

    private let teamNameTextField = {
        let textField = CommonTextField()
        textField.placeholder = "팀 이름을 입력하세요"
        return textField
    }()

    private let goalStepLabel = {
        let label = UILabel()
        label.text = "하루 목표 걸음수"
        label.textAlignment = .left
        label.font = UIFont.customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private lazy var goalStepButton = {
        let btn = UIButton(configuration: buttonConfig)
        btn.layer.cornerRadius = 11
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = .customFont(.notoSans, family: .regular, size: 16)
        btn.contentHorizontalAlignment = .leading
        return btn
    }()

    private let startButton = {
        let btn = CommonButton()
        btn.makeDisable()
        btn.setTitle("시작하기", for: .normal)
        return btn
    }()

    private var disposeBag = DisposeBag()
    private let dropDownView = CustomDropDownView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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

    private func setDropDown() {
        registerDropDrownViews(dropDownView)
        dropDownView.anchorView = goalStepButton
        dropDownView.dataSource = [
            "3,000 걸음",
            "5,000 걸음",
            "10,000 걸음",
            "15,000 걸음",
            "20,000 걸음"
        ]
    }

    private func setupLayout() {
        view.backgroundColor = .white
        setupNavi()
        setDropDown()
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        let subviews = [
            titleLabel, teamNameLabel, teamNameDiscriptionLabel,
            teamNameTextField, goalStepLabel, goalStepButton,
            dropDownView, startButton
        ]
        subviews.forEach(view.addSubview)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(26)
        }

        teamNameDiscriptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }

        teamNameTextField.snp.makeConstraints {
            $0.top.equalTo(teamNameDiscriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        goalStepLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }

        goalStepButton.snp.makeConstraints {
            $0.top.equalTo(goalStepLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        goalStepButton.imageView?.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
        }

        goalStepButton.titleLabel?.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.centerY.equalToSuperview()
        }

        dropDownView.setConstraints { [weak self] make in
            guard let self = self else { return }
            make.leading.trailing.equalTo(goalStepButton)
            make.top.equalTo(goalStepButton.snp.bottom)
        }

        startButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}
