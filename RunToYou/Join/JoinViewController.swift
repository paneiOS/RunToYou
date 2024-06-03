//
//  JoinViewController.swift
//  RunToYou
//
//  Created by 23 09 on 5/30/24.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class JoinViewController: UIViewController, View {
    private var buttonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.imagePadding = 8
        config.contentInsets = .zero
        config.titlePadding = .zero
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        return config
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "거의 다 왔어요!\n런투유 서비스 이용에 필요한\n정보를 입력해 주세요."
        label.textAlignment = .left
        label.font = .customFont(.notoSans, family: .medium, size: 20)
        label.numberOfLines = 3
        return label
    }()

    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private let nickNameTextField: CommonTextField = {
        let textField = CommonTextField()
        textField.placeholder = "닉네임을 입력해주세요"
        return textField
    }()

    private let birthLabel: UILabel = {
        let label = UILabel()
        label.text = "출생연도"
        label.font = .customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private let birthTextField: CommonTextField = {
        let textField = CommonTextField()
        textField.placeholder = "출생 연도를 선택하세요"
        return textField
    }()

    private let yearPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()

    private let sexLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.font = .customFont(.notoSans, family: .regular, size: 18)
        return label
    }()

    private lazy var maleButton: UIButton = {
        var titleString = AttributedString("남성")
        titleString.font = .customFont(.notoSans, family: .regular, size: 16)
        buttonConfig.attributedTitle =  titleString
        let btn = UIButton(type: .custom)
        btn.configuration = buttonConfig
        btn.setImage(.checkBase, for: .normal)
        return btn
    }()

    private lazy var femaleButton: UIButton = {
        var titleString = AttributedString("여성")
        titleString.font = .customFont(.notoSans, family: .regular, size: 16)
        buttonConfig.attributedTitle =  titleString
        let btn = UIButton(type: .custom)
        btn.configuration = buttonConfig
        btn.setImage(.checkBase, for: .normal)
        return btn
    }()

    private lazy var noCommentButton: UIButton = {
        var titleString = AttributedString("대답하고 싶지 않음")
        titleString.font = .customFont(.notoSans, family: .regular, size: 16)
        buttonConfig.attributedTitle =  titleString
        let btn = UIButton(type: .custom)
        btn.configuration = buttonConfig
        btn.setImage(.checkBase, for: .normal)
        return btn
    }()

    private let sexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let nextButton: CommonButton = {
        let btn = CommonButton()
        btn.setupData("다음")
        btn.makeDisable()
        return btn
    }()

    var disposeBag = DisposeBag()
    typealias Reactor = JoinViewReactor
    private let years: [Int] = {
          let currentYear = Calendar.current.component(.year, from: Date())
          return Array((currentYear - 100)...currentYear)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        addSubView()
        setupLayout()
        setupPickerView()
        addTabGuesture()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    private func setupPickerView() {
        birthTextField.inputView = yearPicker
        birthTextField.tintColor = .clear
        Observable.just(years)
            .bind(to: yearPicker.rx.itemTitles) { _, years in
                return "\(years)"
            }
            .disposed(by: disposeBag)
        yearPicker.selectRow(years.count - 1, inComponent: 0, animated: false)
    }

    func bind(reactor: JoinViewReactor) {
        yearPicker.rx.itemSelected
            .map { self.years[$0.row] }
            .map { Reactor.Action.selectYear($0) }
             .bind(to: reactor.action)
             .disposed(by: disposeBag)

        maleButton.rx.tap
            .map { Reactor.Action.checkMale }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        femaleButton.rx.tap
            .map { Reactor.Action.checkFemale }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        noCommentButton.rx.tap
            .map { Reactor.Action.checkNoComment }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        // State
        reactor.state.map { $0.year }
            .filter { $0 != 0 }
            .map { "\($0)" }
            .observe(on: MainScheduler.instance)
            .bind(to: birthTextField.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.maleChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase") }
            .observe(on: MainScheduler.instance)
            .bind(to: maleButton.rx.image())
            .disposed(by: disposeBag)

        reactor.state.map { $0.femaleChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase") }
            .observe(on: MainScheduler.instance)
            .bind(to: femaleButton.rx.image())
            .disposed(by: disposeBag)

        reactor.state.map { $0.noCommentChecked ? UIImage(named: "checkBox") : UIImage(named: "checkBase") }
            .observe(on: MainScheduler.instance)
            .bind(to: noCommentButton.rx.image())
            .disposed(by: disposeBag)
    }

    private func addSubView() {
        sexStackView.addArrangedSubview(maleButton)
        sexStackView.addArrangedSubview(femaleButton)
        sexStackView.addArrangedSubview(noCommentButton)
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(nickNameLabel)
        self.view.addSubview(nickNameTextField)
        self.view.addSubview(birthLabel)
        self.view.addSubview(birthTextField)
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexStackView)
        self.view.addSubview(nextButton)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
        }
        nickNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
        }
        birthLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(20)
        }
        birthTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(birthLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
        }
        sexLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(birthTextField.snp.bottom).offset(20)
        }
        sexStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.top.equalTo(sexLabel.snp.bottom).offset(20)
            $0.height.equalTo(23)
        }
        maleButton.snp.makeConstraints {
            $0.width.equalTo(54)
        }
        femaleButton.snp.makeConstraints {
            $0.width.equalTo(54)
        }
        noCommentButton.snp.makeConstraints {
            $0.width.equalTo(149)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    private func setupNavi() {
        self.title = "회원가입"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white
        appearance.titleTextAttributes = [.font: UIFont.customFont(.notoSans, family: .medium, size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func addTabGuesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
