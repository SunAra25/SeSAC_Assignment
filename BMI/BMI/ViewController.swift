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
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    
    var isHeightValid = false
    var isWeightValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI(titleLabel, title: "BMI Calculator", font: .systemFont(ofSize: 24, weight: .heavy))
        setLabelUI(subTitleLabel, title: "당신의 BMI 지수를 \n알려드릴게요.", font: .systemFont(ofSize: 16))
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
        
        setTextFieldUI(heightTextField)
        setTextFieldUI(weightTextField)
        
        imageView.image = UIImage.image
        imageView.contentMode = .scaleAspectFill
    }

    func setLabelUI(_ label: UILabel, title: String, font: UIFont?) {
        label.text = title
        label.font = font
        label.numberOfLines = 0
    }
    
    func setTextFieldUI(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 16
        textField.keyboardType = .numberPad
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
        
        let alert = UIAlertController(title: "계산 결과 \(result)입니다.", message: "신장 \(height) 몸무게 \(weight)", preferredStyle: .alert)
        
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
    
    @IBAction func endOnExit(_ sender: Any) {
        view.endEditing(true)
    }
}

