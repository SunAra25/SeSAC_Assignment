//
//  ViewController.swift
//  Netflix
//
//  Created by 아라 on 5/14/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldUI(idTextField, title: "이메일 주소 또는 전화번호")
        setTextFieldUI(passwordTextField, title: "비밀번호")
        setTextFieldUI(nicknameTextField, title: "닉네임")
        setTextFieldUI(addressTextField, title: "위치")
        setTextFieldUI(codeTextField, title: "추천 코드 입력")
        
        passwordTextField.isSecureTextEntry = true
        joinButton.isEnabled = false
    }
    
    @IBAction func checkJoinEnable(_ sender: UITextField) {
        joinButton.isEnabled = isIdVaild() && isPasswordVaild() && isCodeVaild()
    }
    
    @IBAction func joinButtonDidTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "회원가입에 성공하였습니다", message: "로그인 하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func setTextFieldUI(_ textField: UITextField, title: String) {
        textField.attributedPlaceholder = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.white])
    }
    
    func isIdVaild() -> Bool {
        idTextField.text?.count ?? 0 > 0
    }
    
    func isPasswordVaild() -> Bool {
        passwordTextField.text?.count ?? 0 >= 6
    }
    
    func isCodeVaild() -> Bool {
        guard let codeString = codeTextField.text, let _ = Int(codeString) else { return false }
        
        return true
    }
}
