//
//  AgreementViewController.swift
//  RunToYou
//
//  Created by 23 09 on 5/28/24.
//

import UIKit
import SnapKit

class AgreementViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "런투유 서비스를 이용하기 위한\n약관에 동의해주세요"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .customFont(.notoSans, family: .medium, size: 20)
        return label
    }()

    private let allAgreeView: UIView = {
        let view = CheckView()
        view.setupData(ment: "전체 동의합니다.", fontSize: 20)
        return view
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 0.2)
        return view
    }()

    private let termsUseAgreeView: UIView = {
        let view = CheckView()
        view.setupData(linkMent: "서비스 이용약관", ment: "동의(필수)")
        return view
    }()

    private let privacyAgreeView: UIView = {
        let view = CheckView()
        view.setupData(linkMent: "개인정보 처리방침", ment: "동의(필수)")
        return view
    }()

    private let ageAgreeView: UIView = {
        let view = CheckView()
        view.setupData(ment: "만 14세 이상 (필수)")
        return view
    }()

    private let healthAgreeView: UIView = {
        let view = CheckView()
        view.setupData(linkMent: "건강,민감정보 수집이용", ment: "동의(필수)")
        return view
    }()
    private let gpsAgreeView: UIView = {
        let view = CheckView()
        view.setupData(ment: "GPS 수집이용 동의(선택)")
        return view
    }()

    private let eventAgreeView: UIView = {
        let view = CheckView()
        view.setupData(linkMent: "이벤트,혜택소식", ment: "받기 (선택)")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavi()
        addSubView()
        setupLayout()
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print("Font: \(fontName)")
            }
        }
    }

    deinit {
        print("\(type(of: self)): Deinited")
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
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        allAgreeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
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
    }
}

final class CheckView: UIView {
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.customFont(.notoSans, family: .regular, size: 14),
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .foregroundColor: UIColor.black
    ]

    private let checkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage( .checkBase, for: .normal)
        return btn
    }()

    private let link: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()

    private let agreeButton: UIButton = {
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
