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
        
        idTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [.foregroundColor : UIColor.white])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor : UIColor.white])
        passwordTextField.isSecureTextEntry = true
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor : UIColor.white])
        addressTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor : UIColor.white])
        codeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [.foregroundColor : UIColor.white])
        
        joinButton.isEnabled = false
    }
    
    @IBAction func idEndEditing(_ sender: UITextField) {
        joinButton.isEnabled = isJoinBtnVaild()
    }
    
    @IBAction func passwordEndEditing(_ sender: UITextField) {
        joinButton.isEnabled = isJoinBtnVaild()
    }
    
    
    @IBAction func codeEndEditing(_ sender: UITextField) {
        joinButton.isEnabled = isJoinBtnVaild()
    }
    
    @IBAction func joinButtonDidTapped(_ sender: UIButton) {
        print("회원가입 버튼이 눌렸습니다")
    }
    
    func isIdVaild() -> Bool {
        idTextField.text?.count ?? 0 > 0
    }
    
    func isPasswordVaild() -> Bool {
        passwordTextField.text?.count ?? 0 >= 6
    }
    
    func isCodeVaild() -> Bool {
        guard let codeString = codeTextField.text, let code = Int(codeString) else { return false }
        
        return true
    }
    
    func isJoinBtnVaild() -> Bool {
        isIdVaild() && isPasswordVaild() && isCodeVaild()
    }
}
