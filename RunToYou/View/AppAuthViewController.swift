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
    let disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 서비스 접근 권한 안내"
        label.textAlignment = .center
        label.font = .customFont(.notoSans, family: .regular, size: 24)
        return label
    }()

    private let recordRow = AuthViewRow(
        imageName: "smart_phone",
        titleString: "기기 및 앱 기록",
        detailString: "서비스 개선 및 오류 확인",
        isOptional: false
    )

    private let alarmRow = AuthViewRow(
        imageName: "bell",
        titleString: "알림",
        detailString: "푸시 알림 및 메시지 수신 안내",
        isOptional: true)

    private let cameraRow = AuthViewRow(
        imageName: "photo_camera",
        titleString: "사진/카메라",
        detailString: "채팅방 사진 업로드",
        isOptional: true)

    private let locationRow = AuthViewRow(
        imageName: "location_on",
        titleString: "위치",
        detailString: "현재 위치 및 이동경로 GPS 기능",
        isOptional: true)

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
        btn.backgroundColor = UIColor.customColor(.mainDark)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .customFont(.notoSans, family: .regular, size: 18)
        btn.layer.cornerRadius = 7
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setupLayout()
    }

    private func setAddTarget() {
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goNextView()
            })
            .disposed(by: disposeBag)
    }

    private func goNextView() {
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(recordRow)
        self.view.addSubview(alarmRow)
        self.view.addSubview(cameraRow)
        self.view.addSubview(locationRow)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().inset(140)
        }

        recordRow.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        alarmRow.snp.makeConstraints {
            $0.top.equalTo(recordRow.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        cameraRow.snp.makeConstraints {
            $0.top.equalTo(alarmRow.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        locationRow.snp.makeConstraints {
            $0.top.equalTo(cameraRow.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(locationRow.snp.bottom).offset(60)
            $0.width.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

    }

    deinit {
        print("\(type(of: self)): Deinited")
    }
}

final private class AuthViewRow: UIView {
    let imageView: UIImageView
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .customFont(.notoSans, family: .medium, size: 16)
        return label
    }()
    let detailLabel: UILabel = {
        let label = UILabel()
         label.font = .customFont(.notoSans, family: .regular, size: 14)
         return label
     }()
    let optionalLabel: UILabel = {
        let label = UILabel()
         label.text = " (선택)"
        label.font = .customFont(.notoSans, family: .thin, size: 12)
         return label
     }()

    init( imageName: String, titleString: String, detailString: String, isOptional: Bool) {
        self.titleLabel.text = titleString
        self.detailLabel.text = detailString
        self.imageView = UIImageView(image: UIImage(named: imageName)!)
        if !isOptional {
            self.optionalLabel.isHidden = true
        }
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
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
