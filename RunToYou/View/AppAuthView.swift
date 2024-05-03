//
//  AppAuthView.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/02.
//

import UIKit

class AppAuthView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 서비스 접근 권한 안내"
        label.textAlignment = .center
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 24)
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 60
        sv.alignment = .leading
        sv.addArrangedSubview(titleLabel)
        sv.addArrangedSubview(listStackView)
        sv.addArrangedSubview(descriptionLabel)
        return sv
    }()
    
    lazy var listStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .leading
        sv.spacing = 10
        sv.addArrangedSubview(recordHStackView)
        sv.addArrangedSubview(alarmHStackView)
        sv.addArrangedSubview(cameraHStackView)
        sv.addArrangedSubview(locationHStackView)
        return sv
    }()
    
    lazy var recordHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 9.5
        sv.addArrangedSubview(phoneIcon)
        sv.addArrangedSubview(recordVStackView)
        
        return sv
    }()
    
    lazy var recordVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.addArrangedSubview(recordLabel)
        sv.addArrangedSubview(recordDetailLabel)
        
        return sv
    }()
    
    let recordLabel: UILabel = {
        let label = UILabel()
        label.text = "기기 및 앱 기록"
        label.textAlignment = .left
        label.font = UIFont.customFont(.NotoSans, family: .Medium, size: 16)
        return label
    }()
    let recordDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 개선 및 오류 확인"
        label.textAlignment = .left
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 14)
        return label
    }()
    
    let phoneIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "smartphone")!)
        return image
    }()
    
    lazy var alarmHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 9.5
        sv.addArrangedSubview(bellIcon)
        sv.addArrangedSubview(alarmVStackView)
        
        return sv
    }()
    
    lazy var alarmVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.addArrangedSubview(alarmLabel)
        sv.addArrangedSubview(alarmDetailLabel)
        
        return sv
    }()
    
    let alarmLabel: UILabel = {
        let label = UILabel()
        let attributedText = UIFont.attributedTextWithTwoFonts(text1: "알림", font1: UIFont.customFont(.NotoSans, family: .Medium, size: 16), text2: " (선택)", font2: UIFont.customFont(.NotoSans, family: .Medium, size: 12))
        label.attributedText = attributedText
        label.textAlignment = .left
        return label
    }()
    let alarmDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "푸시 알림 및 메시지 수신 안내"
        label.textAlignment = .left
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 14)
        return label
    }()
    
    let bellIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "bell")!)
        return image
    }()
    
    lazy var cameraHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 9.5
        sv.addArrangedSubview(cameraIcon)
        sv.addArrangedSubview(cameraVStackView)
        
        return sv
    }()
    
    lazy var cameraVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.addArrangedSubview(cameraLabel)
        sv.addArrangedSubview(cameraDetailLabel)
        
        
        return sv
    }()
    
    let cameraLabel: UILabel = {
        let label = UILabel()
        let attributedText = UIFont.attributedTextWithTwoFonts(text1: "사진/카메라", font1: UIFont.customFont(.NotoSans, family: .Medium, size: 16), text2: " (선택)", font2: UIFont.customFont(.NotoSans, family: .Medium, size: 12))
        label.attributedText = attributedText
        label.textAlignment = .left
        return label
    }()
    let cameraDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅방 사진 업로드"
        label.textAlignment = .left
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 14)
        return label
    }()
    
    let cameraIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo_camera")!)
        return image
    }()
    

    
    
    lazy var locationHStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 9.5
        sv.addArrangedSubview(locationIcon)
        sv.addArrangedSubview(locationVStackView)
        
        return sv
    }()
    
    lazy var locationVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.addArrangedSubview(locationLabel)
        sv.addArrangedSubview(locationDetailLabel)
        
        
        return sv
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        let attributedText = UIFont.attributedTextWithTwoFonts(text1: "위치", font1: UIFont.customFont(.NotoSans, family: .Medium, size: 16), text2: " (선택)", font2: UIFont.customFont(.NotoSans, family: .Medium, size: 12))
        label.attributedText = attributedText
        label.textAlignment = .left
        return label
    }()
    let locationDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 위치 및 이동경로 GPS 기능"
        label.textAlignment = .left
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 14)
        return label
    }()
    
    let locationIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "location_on")!)
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "* 권한을 허용하지 않아도 앱 이용이 가능하지만 \n 일부 서비스가 제한될 수 있습니다"
        label.font = UIFont.customFont(.NotoSans, family: .Regular, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = UIColor.customColor(.MainDark)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.customFont(.NotoSans, family: .Regular, size: 18)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    func setupLayout() {
        self.backgroundColor = .white
        self.addSubview(titleLabel)
        self.addSubview(mainStackView)
        self.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
  
        mainStackView.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide)
            make.right.equalTo(self.safeAreaLayoutGuide)
            make.top.equalToSuperview().offset(140)
            make.bottom.equalToSuperview().offset(-243)
        }
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        phoneIcon.snp.makeConstraints { make in
            make.width.equalTo(14)
            make.height.equalTo(22)
            make.left.equalTo(recordHStackView.snp.left).offset(32)
        }
        
        bellIcon.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.left.equalTo(alarmHStackView.snp.left).offset(27)
        }
        
        cameraIcon.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.left.equalTo(cameraHStackView.snp.left).offset(27)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.left.equalTo(locationHStackView.snp.left).offset(27)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(50)
        }
    }
    
}
