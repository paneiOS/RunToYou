//
//  AppAuthViewController.swift
//  RunToYou
//
//  Created by 이정환 on 4/22/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AppAuthViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private let recordRowView: AuthViewRow = {
        let view = AuthViewRow()
        view.setupData(
            image: .smartPhone,
            titleString: "기기 및 앱 기록",
            detailString: "서비스 개선 및 오류 확인",
            isOptional: false)
        return view
    }()

    private let alarmRowView: AuthViewRow = {
        let view = AuthViewRow()
        view.setupData(
            image: .bell,
            titleString: "알림",
            detailString: "푸시 알림 및 메시지 수신 안내",
            isOptional: true)
        return view
    }()

    private let cameraRowView: AuthViewRow = {
        let view = AuthViewRow()
        view.setupData(
            image: .photoCamera,
            titleString: "사진/카메라",
            detailString: "채팅방 사진 업로드",
            isOptional: true)
        return view
    }()

    private let locationRowView: AuthViewRow = {
        let view = AuthViewRow()
        view.setupData(
            image: .locationOn,
            titleString: "위치",
            detailString: "현재 위치 및 이동경로 GPS 기능",
            isOptional: true)
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 서비스 접근 권한 안내"
        label.textAlignment = .center
        label.font = .customFont(.notoSans, family: .regular, size: 24)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "* 권한을 허용하지 않아도 앱 이용이 가능하지만 \n 일부 서비스가 제한될 수 있습니다"
        label.font = .customFont(.notoSans, family: .regular, size: 14)
        label.textAlignment = .center
        return label
    }()

    private let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .customColor(.mainDark)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .customFont(.notoSans, family: .regular, size: 18)
        btn.layer.cornerRadius = 7
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTarget()
        setupLayout()
    }

    deinit {
        print("\(type(of: self)): Deinited")
    }

    private func setupTarget() {
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.goNextView()
            })
            .disposed(by: disposeBag)
    }

    // TODO: 로그인화면 이동
    private func goNextView() {
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(recordRowView)
        self.view.addSubview(alarmRowView)
        self.view.addSubview(cameraRowView)
        self.view.addSubview(locationRowView)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().inset(140)
        }

        recordRowView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        alarmRowView.snp.makeConstraints {
            $0.top.equalTo(recordRowView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        cameraRowView.snp.makeConstraints {
            $0.top.equalTo(alarmRowView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        locationRowView.snp.makeConstraints {
            $0.top.equalTo(cameraRowView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(locationRowView.snp.bottom).offset(60)
            $0.width.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

    }
}

final class AuthViewRow: UIView {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .customFont(.notoSans, family: .medium, size: 16)
        return label
    }()
    private let detailLabel: UILabel = {
        let label = UILabel()
         label.font = .customFont(.notoSans, family: .regular, size: 14)
         return label
     }()
    private let optionalLabel: UILabel = {
        let label = UILabel()
         label.text = " (선택)"
        label.font = .customFont(.notoSans, family: .thin, size: 12)
         return label
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

    func setupData(image: UIImage, titleString: String, detailString: String, isOptional: Bool) {
        self.titleLabel.text = titleString
        self.detailLabel.text = detailString
        self.imageView.image = image
        self.optionalLabel.isHidden = !isOptional
    }

    private func setupLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(optionalLabel)
        addSubview(detailLabel)

        self.snp.makeConstraints {
            $0.height.equalTo(51)
        }

        imageView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalTo(imageView.snp.trailing).offset(24)
        }

        optionalLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3)
        }

        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(imageView.snp.trailing).offset(24)
        }
    }
}
