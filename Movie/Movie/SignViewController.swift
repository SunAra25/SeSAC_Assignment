//
//  SignViewController.swift
//  Movie
//
//  Created by 아라 on 6/4/24.
//

import UIKit
import SnapKit

class SignViewController: UIViewController {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SUNFLIX"
        label.textAlignment = .center
        label.textColor = .red
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.text = "이메일 주소 또는 전화번호"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 12
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "비밀번호"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 12
        return textField
    }()
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "닉네임"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 12
        return textField
    }()
    let locationTextField: UITextField = {
        let textField = UITextField()
        textField.text = "위치"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 12
        return textField
    }()
    let codeTextField: UITextField = {
        let textField = UITextField()
        textField.text = "추천 코드 입력"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 12
        return textField
    }()
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        return button
    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    let switchView: UISwitch = {
        let view = UISwitch()
        view.isOn = true
        view.onTintColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setHierachy()
        setConstraints()
    }

    func configureView() {
        view.backgroundColor = .black
        signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    func setHierachy() {
        [nameLabel, idTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField, signUpButton, infoLabel, switchView].forEach {
            view.addSubview($0)
        }
    }

    func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
        }
        
        switchView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func signUpButtonDidTap() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

