//
//  SelectAlertView.swift
//  Tamagotchi
//
//  Created by 아라 on 6/9/24.
//

import UIKit
import SnapKit

class SelectAlertView: UIView {
    let tamagotchiImageView = UIImageView()
    let nameView = TamagotchiNameView()
    let dividerView = UIView()
    let contentLabel = UILabel()
    let buttonView = UIView()
    let cancelButton = UIButton()
    let startButton = UIButton()
    let changeButton = UIButton()
    
    var tamagotchi: Tamagotchi?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .back
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        contentLabel.textColor = .font
        contentLabel.textAlignment = .center
        contentLabel.font = .capM
        contentLabel.numberOfLines = 0
        
        dividerView.backgroundColor = .border?.withAlphaComponent(0.5)
        
        buttonView.backgroundColor = .border?.withAlphaComponent(0.3)
        
        var cancleBtnConfig = UIButton.Configuration.plain()
        var cancleBtnAttr = AttributedString.init("취소")
        cancleBtnAttr.font = .bodyB
        cancleBtnConfig.attributedTitle = cancleBtnAttr
        cancleBtnConfig.baseForegroundColor = .font
        
        cancelButton.configuration = cancleBtnConfig
        cancelButton.backgroundColor = .back
        
        var startBtnConfig = UIButton.Configuration.plain()
        var startBtnAttr = AttributedString.init("시작하기")
        startBtnAttr.font = .bodyB
        startBtnConfig.attributedTitle = startBtnAttr
        startBtnConfig.baseForegroundColor = .font
        
        startButton.configuration = startBtnConfig
        startButton.backgroundColor = .back
        startButton.isHidden = true
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        
        var changeBtnConfig = UIButton.Configuration.plain()
        var changeBtnAttr = AttributedString.init("시작하기")
        changeBtnAttr.font = .bodyB
        changeBtnConfig.attributedTitle = changeBtnAttr
        changeBtnConfig.baseForegroundColor = .font
        
        changeButton.configuration = changeBtnConfig
        changeButton.backgroundColor = .back
        changeButton.isHidden = true
        changeButton.addTarget(self, action: #selector(changeButtonDidTap), for: .touchUpInside)
    }
    
    
    func setLayout() {
        [tamagotchiImageView, nameView, dividerView, contentLabel, buttonView].forEach {
            self.addSubview($0)
        }
        
        [cancelButton, startButton, changeButton].forEach {
            buttonView.addSubview($0)
        }
        
        tamagotchiImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(40)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(52)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(1)
            make.leading.bottom.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing).offset(1)
            make.trailing.bottom.equalToSuperview()
            make.top.width.equalTo(cancelButton)
        }
        
        changeButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing).offset(1)
            make.trailing.bottom.equalToSuperview()
            make.top.width.equalTo(cancelButton)
        }
    }
    
    func configureTamagotchi(type: SelectButton, _ data: Tamagotchi) {
        switch type {
        case .start: startButton.isHidden = false
        case .change: changeButton.isHidden = false
        }
        
        tamagotchi = data
        
        tamagotchiImageView.image = data.tamagoImage
        nameView.nameLabel.text = data.rawValue
        contentLabel.text = data.tamagoInfo
    }
    
    @objc func startButtonDidTap() {
        let mvc = MainViewController()
        mvc.tamagotchi = tamagotchi
        
        let nav = UINavigationController(rootViewController: mvc)
        
        DispatchQueue.main.async {
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
    }
    
    @objc func changeButtonDidTap() {
        // TODO: 다마고치 변경 후 화면 전환
    }
}
