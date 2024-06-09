//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit
import SnapKit

class MainViewController: BaseNavigationViewController {
    let bubbleImageView = UIImageView()
    let messageLabel = UILabel()
    let tamagotchiImageView = UIImageView()
    let nameView = TamagotchiNameView()
    let infoLabel = UILabel()
    let foodTextField = UITextField()
    let foodView = UIView()
    let waterTextField = UITextField()
    let waterView = UIView()
    let foodButton = UIButton()
    let waterButton = UIButton()
    
    let userDefaults = UserDefaultsManager()
    var tamagotchi: Tamagotchi?
    lazy var messages = [
        "\(userDefaults.nickname)님~\n오늘 깃허브 푸시는 하셨나요?",
        "과제 끝내고 가셔야죠 \(userDefaults.nickname)님^ㅡ^",
        "복습 아직 안하셨다구요..?\n지금 잠이 오세여 \(userDefaults.nickname)님?",
        "테이블뷰 컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?!"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setHierarchy()
        setConstraints()
    }
    
    override func configureView() {
        guard let tamagotchi = tamagotchi else { return }
        
        super.configureView()
        
        setRightBarButtonItemAsSetting()
        title = "\(userDefaults.nickname)님의 다마고치"
        
        bubbleImageView.image = UIImage.bubble
        
        tamagotchiImageView.image = UIImage(named: "\(tamagotchi.index!)-\(userDefaults.level)")
        
        let randomIdx = Int.random(in: 0...100)
        messageLabel.text = messages[randomIdx % 4]
        messageLabel.textColor = .font
        messageLabel.textAlignment = .center
        messageLabel.font = .bodyM
        messageLabel.numberOfLines = 0
        
        nameView.nameLabel.text = tamagotchi.rawValue
        
        infoLabel.text = "LV\(userDefaults.level) • 밥알 \(userDefaults.food)개 • 물방울 \(userDefaults.water)개"
        infoLabel.textColor = .font
        infoLabel.textAlignment = .center
        infoLabel.font = .subB
        
        foodTextField.placeholder = "밥주세용"
        foodTextField.textColor = .font
        foodTextField.textAlignment = .center
        foodTextField.font = .subB
        foodTextField.keyboardType = .numberPad
        
        foodView.backgroundColor = .border
        
        waterTextField.placeholder = "물주세용"
        waterTextField.textColor = .font
        waterTextField.textAlignment = .center
        waterTextField.font = .subB
        waterTextField.keyboardType = .numberPad
        
        waterView.backgroundColor = .border
        
        var foodBtnConfig = UIButton.Configuration.plain()
        var foodBtnAttr = AttributedString.init("밥먹기")
        foodBtnAttr.font = .bodyB
        foodBtnConfig.attributedTitle = foodBtnAttr
        foodBtnConfig.image = .feedingFood
        foodBtnConfig.imagePadding = 4
        foodBtnConfig.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        foodButton.configuration = foodBtnConfig
        foodButton.tintColor = .font
        foodButton.layer.cornerRadius = 8
        foodButton.layer.borderWidth = 1
        foodButton.layer.borderColor = UIColor.border?.cgColor
        
        var waterBtnConfig = UIButton.Configuration.plain()
        var waterBtnAttr = AttributedString.init("물주기")
        waterBtnAttr.font = .bodyB
        waterBtnConfig.attributedTitle = waterBtnAttr
        waterBtnConfig.image = .feedingWater
        waterBtnConfig.imagePadding = 4
        waterBtnConfig.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        waterButton.configuration = waterBtnConfig
        waterButton.tintColor = .font
        waterButton.layer.cornerRadius = 8
        waterButton.layer.borderWidth = 1
        waterButton.layer.borderColor = UIColor.border?.cgColor
    }
    
    func setHierarchy() {
        [bubbleImageView, messageLabel, tamagotchiImageView, nameView, infoLabel, foodTextField, foodView, waterTextField, waterView, foodButton, waterButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints() {
        bubbleImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bubbleImageView)
            make.centerY.equalTo(bubbleImageView).offset(-6)
            make.verticalEdges.greaterThanOrEqualTo(bubbleImageView).inset(12)
            make.horizontalEdges.greaterThanOrEqualTo(bubbleImageView).inset(12)
        }
        
        tamagotchiImageView.snp.makeConstraints { make in
            make.top.equalTo(bubbleImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(95)
            make.height.equalTo(tamagotchiImageView.snp.width)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        foodButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.trailing.equalToSuperview().inset(56)
        }
        
        foodView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(56)
            make.trailing.equalTo(foodButton.snp.leading).offset(-12)
            make.bottom.equalTo(foodButton)
            make.height.equalTo(1)
        }
        
        foodTextField.snp.makeConstraints { make in
            make.top.equalTo(foodButton)
            make.bottom.equalTo(foodView.snp.top)
            make.horizontalEdges.equalTo(foodView)
        }
        
        waterButton.snp.makeConstraints { make in
            make.top.equalTo(foodView.snp.bottom).offset(32)
            make.trailing.equalToSuperview().inset(56)
        }
        
        waterView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(56)
            make.trailing.equalTo(waterButton.snp.leading).offset(-12)
            make.bottom.equalTo(waterButton)
            make.height.equalTo(1)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(waterButton)
            make.bottom.equalTo(waterView.snp.top)
            make.horizontalEdges.equalTo(waterView)
        }
    }
}
