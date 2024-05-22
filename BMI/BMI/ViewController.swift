//
//  ViewController.swift
//  BMI
//
//  Created by 아라 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    var isHeightValid = false
    var isWeightValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nickname = getUserNickname()
        let height = getUserHeight()
        let weight = getUserWeight()
        
        setLabelUI(titleLabel, title: "BMI Calculator", font: .systemFont(ofSize: 24, weight: .heavy))
        setLabelUI(subTitleLabel, title: "\(nickname == "" ? "당신" : nickname)의 BMI 지수를 \n알려드릴게요.", font: .systemFont(ofSize: 16))
        setLabelUI(nicknameLabel, title: "닉네임이 어떻게 되시나요?", font: .systemFont(ofSize: 16))
        setLabelUI(heightLabel, title: "키가 어떻게 되시나요?", font: .systemFont(ofSize: 16))
        setLabelUI(weightLabel, title: "몸무게는 어떻게 되시나요?", font: .systemFont(ofSize: 16))
        
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.setTitleColor(.purple, for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        calculateButton.isEnabled = false
        calculateButton.setTitle("결과 확인", for: .normal)
        calculateButton.setTitleColor(.darkGray, for: .disabled)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calculateButton.backgroundColor = .lightGray
        calculateButton.layer.cornerRadius = 12
        
        resetButton.setTitle("Reset", for: .normal)
        
        setTextFieldUI(heightTextField, placeholder: height == 0 ? "" : "\(height)")
        setTextFieldUI(weightTextField, placeholder: weight == 0 ? "" : "\(weight)")
        setTextFieldUI(nicknameTextField, placeholder: nickname)
        
        imageView.image = UIImage.image
        imageView.contentMode = .scaleAspectFill
    }
    
    func setLabelUI(_ label: UILabel, title: String, font: UIFont?) {
        label.text = title
        label.font = font
        label.numberOfLines = 0
    }
    
    func setTextFieldUI(_ textField: UITextField, placeholder: String) {
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 16
        textField.keyboardType = .numberPad
        textField.placeholder = placeholder
    }
    
    func getUserNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: "nickname") else { return "" }
        return nickname
    }
    
    func getUserHeight() -> Int {
        UserDefaults.standard.integer(forKey: "height")
    }
    
    func getUserWeight() -> Int {
        UserDefaults.standard.integer(forKey: "weight")
    }
    
    func setUserInfo() {
        UserDefaults.standard.set(nicknameTextField.text, forKey: "nickname")
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
    }
    
    func displayResult(height: Int, weight: Int, num: Double) {
        var result = ""
        switch num {
        case ...18.5: result = "저체중"
        case 18.6..<23: result = "정상체중"
        case 23..<25: result = "과체중"
        case 25..<30: result = "비만"
        case 30...: result = "고도비만"
        default: break
        }
        let nickname = getUserNickname()
        let alert = UIAlertController(title: "\(nickname)님의 BMI 수치는 \(num)로 \(result)입니다.", message: "신장 \(height) 몸무게 \(weight)", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        present(alert, animated: true)
    }
    
    func calculateBMI(height: Int, weight: Int) -> Double {
        return Double(weight) / Double(height * height) * 10000
    }
    
    @IBAction func calcuateUserInfo(_ sender: UIButton) {
        guard let heightString = heightTextField.text, let height = Int(heightString) else { return }
        guard let weightString = weightTextField.text, let weight = Int(weightString) else { return }
        
        let result = calculateBMI(height: height, weight: weight)
        setUserInfo()
        displayResult(height: height, weight: weight, num: result)
    }
    
    @IBAction func randomCalculate(_ sender: UIButton) {
        let height = Int.random(in: 100...200)
        let weight = Int.random(in: 30...150)
        
        let result = calculateBMI(height: height, weight: weight)
        displayResult(height: height, weight: weight, num: result)
    }
    
    
    @IBAction func checkTextFieldInput(_ sender: UITextField) {
        guard let input = sender.text else { return }
        let new = input.filter { $0 != " " }
        
        guard let num = Int(new) else { return }
        
        isHeightValid = sender == heightTextField ? (100...200) ~= num : isHeightValid
        
        isWeightValid = sender == weightTextField ? (30...150) ~= num : isWeightValid
        
        calculateButton.isEnabled = isHeightValid && isWeightValid
        calculateButton.backgroundColor = calculateButton.isEnabled ? .purple : .lightGray
    }
    
    @IBAction func resetButtonDidTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "height")
        UserDefaults.standard.removeObject(forKey: "weight")
        
        nicknameTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    @IBAction func endOnExit(_ sender: Any) {
        view.endEditing(true)
    }
}

