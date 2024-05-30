//
//  AgreementViewController.swift
//  RunToYou
//
//  Created by 23 09 on 5/28/24.
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa
import RxSwift

class AgreementViewController: UIViewController, View {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "런투유 서비스를 이용하기 위한\n약관에 동의해주세요"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .customFont(.notoSans, family: .medium, size: 20)
        return label
    }()

    private let allAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(ment: "전체 동의합니다.", fontSize: 16)
        return view
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 0.2)
        return view
    }()

    private let termsUseAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(linkMent: "서비스 이용약관", ment: "동의(필수)")
        return view
    }()

    private let privacyAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(linkMent: "개인정보 처리방침", ment: "동의(필수)")
        return view
    }()

    private let ageAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(ment: "만 14세 이상 (필수)")
        return view
    }()

    private let healthAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(linkMent: "건강,민감정보 수집이용", ment: "동의(필수)")
        return view
    }()
    private let gpsAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(ment: "GPS 수집이용 동의(선택)")
        return view
    }()

    private let eventAgreeView: CheckView = {
        let view = CheckView()
        view.setupData(linkMent: "이벤트,혜택소식", ment: "받기 (선택)")
        return view
    }()

    private let nextButton: CommonButton = {
        let btn = CommonButton()
        btn.setupData("다음")
        btn.makeDisable()
        return btn
    }()

    typealias Reactor = AgreementViewReactor
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.reactor = AgreementViewReactor()
        setupNavi()
        addSubView()
        setupLayout()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func bind(reactor: AgreementViewReactor) {
        // Action
        bindButton(allAgreeView.checkButton, to: .agreeAll, reactor)
        bindButton(allAgreeView.agreeButton, to: .agreeAll, reactor)
        bindButton(termsUseAgreeView.checkButton, to: .agreeUseTerm, reactor)
        bindButton(termsUseAgreeView.agreeButton, to: .agreeUseTerm, reactor)
        bindButton(privacyAgreeView.checkButton, to: .agreePrivacy, reactor)
        bindButton(privacyAgreeView.agreeButton, to: .agreePrivacy, reactor)
        bindButton(ageAgreeView.checkButton, to: .agreeAge, reactor)
        bindButton(ageAgreeView.agreeButton, to: .agreeAge, reactor)
        bindButton(healthAgreeView.checkButton, to: .agreeHealth, reactor)
        bindButton(healthAgreeView.agreeButton, to: .agreeHealth, reactor)
        bindButton(gpsAgreeView.checkButton, to: .agreeGps, reactor)
        bindButton(gpsAgreeView.agreeButton, to: .agreeGps, reactor)
        bindButton(eventAgreeView.checkButton, to: .agreeEvent, reactor)
        bindButton(eventAgreeView.agreeButton, to: .agreeEvent, reactor)
        bindButton(nextButton, to: .goNextPage, reactor)
        // State
        bindImage(reactor, path: \.allChecked, button: allAgreeView.checkButton)
        bindImage(reactor, path: \.termUseChecked, button: termsUseAgreeView.checkButton)
        bindImage(reactor, path: \.privacyChecked, button: privacyAgreeView.checkButton)
        bindImage(reactor, path: \.ageChecked, button: ageAgreeView.checkButton)
        bindImage(reactor, path: \.healthChecked, button: healthAgreeView.checkButton)
        bindImage(reactor, path: \.gpsChecked, button: gpsAgreeView.checkButton)
        bindImage(reactor, path: \.eventChecked, button: eventAgreeView.checkButton)

        Observable.combineLatest(
             reactor.state.map { $0.termUseChecked },
             reactor.state.map { $0.privacyChecked },
             reactor.state.map { $0.ageChecked },
             reactor.state.map { $0.healthChecked }

         )
         .map { $0 && $1 && $2 && $3 }
         .distinctUntilChanged()
         .observe(on: MainScheduler.instance)
         .bind(onNext: { [weak self] isChecked in
             guard let self = self else { return }
             isChecked ? (self.nextButton.makeEnable()) : self.nextButton.makeDisable()
         })
         .disposed(by: disposeBag)

        reactor.action.filter { $0 == .goNextPage }
            .subscribe(onNext: { [weak self] _ in
                self?.goNextPage()
            })
            .disposed(by: disposeBag)
    }

    private func bindButton(_ button: UIButton, to action: Reactor.Action, _ reactor: AgreementViewReactor) {
        button.rx.tap
            .map { action }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func bindImage(_ reactor: AgreementViewReactor, path: KeyPath<AgreementViewReactor.State, Bool>, button: UIButton) {
        reactor.state.map { state in
            return state[keyPath: path] ? UIImage(named: "checkBox") : UIImage(named: "checkBase") }
            .observe(on: MainScheduler.instance)
            .bind(to: button.rx.image())
            .disposed(by: disposeBag)
    }
    // TODO: 회원가입 화면 이동 개발
    private func goNextPage() {
    }

    private func setupNavi() {
        self.title = "약관동의"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white
        appearance.titleTextAttributes = [.font: UIFont.customFont(.notoSans, family: .medium, size: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func addSubView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(allAgreeView)
        self.view.addSubview(divider)
        self.view.addSubview(termsUseAgreeView)
        self.view.addSubview(privacyAgreeView)
        self.view.addSubview(ageAgreeView)
        self.view.addSubview(healthAgreeView)
        self.view.addSubview(gpsAgreeView)
        self.view.addSubview(eventAgreeView)
        self.view.addSubview(nextButton)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        allAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(20)
        }
        divider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(allAgreeView.snp.bottom).offset(20)
            $0.height.equalTo(1)
        }
        termsUseAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(divider.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        privacyAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(termsUseAgreeView.snp.bottom).offset(12)
            $0.height.equalTo(20)
        }
        ageAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(privacyAgreeView.snp.bottom).offset(12)
            $0.height.equalTo(20)
        }
        healthAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(ageAgreeView.snp.bottom).offset(12)
            $0.height.equalTo(20)
        }
        gpsAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(healthAgreeView.snp.bottom).offset(12)
            $0.height.equalTo(20)
        }
        eventAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(gpsAgreeView.snp.bottom).offset(12)
            $0.height.equalTo(20)
        }
        nextButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

final class CheckView: UIView {
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.customFont(.notoSans, family: .regular, size: 14),
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .foregroundColor: UIColor.black
    ]

    let checkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage( .checkBase, for: .normal)
        return btn
    }()

    private let link: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()

    let agreeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .customFont(.notoSans, family: .regular, size: 14)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    func setupData(linkMent: String = "", ment: String, fontSize: CGFloat = 14) {
        link.setAttributedTitle(NSAttributedString(string: "\(linkMent) ", attributes: attributes), for: .normal)
        if linkMent.isEmpty {
            reConstraintsLink()
        }
        agreeButton.setTitle(ment, for: .normal)
        agreeButton.titleLabel?.font = .customFont(.notoSans, family: .regular, size: fontSize)
    }

    private func setupLayout() {
        addSubview(checkButton)
        addSubview(link)
        addSubview(agreeButton)
        checkButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        link.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        agreeButton.snp.makeConstraints {
            $0.leading.equalTo(link.snp.trailing)
            $0.centerY.equalToSuperview()
        }
    }

    private func reConstraintsLink() {
        link.isHidden = true
        link.snp.removeConstraints()
        link.snp.makeConstraints {
            $0.leading.trailing.equalTo(checkButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
