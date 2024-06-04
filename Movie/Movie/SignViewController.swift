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
    }
    
    func setHierachy() {
    }

    func setConstraints() {
    }
}

