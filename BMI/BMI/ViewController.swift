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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUI(titleLabel, title: "BMI Calculator", font: .systemFont(ofSize: 24, weight: .heavy))
        setLabelUI(subTitleLabel, title: "당신의 BMI 지수를 \n알려드릴게요.", font: .systemFont(ofSize: 16))
        setLabelUI(heightLabel, title: "키가 어떻게 되시나요?", font: .systemFont(ofSize: 16))
        setLabelUI(weightLabel, title: "몸무게는 어떻게 되시나요?", font: .systemFont(ofSize: 16))
        
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.setTitleColor(.purple, for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        calculateButton.setTitle("결과 확인", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        calculateButton.backgroundColor = .purple
        calculateButton.layer.cornerRadius = 12
        calculateButton.isEnabled = false
        
        setTextFieldUI(heightTextField)
        setTextFieldUI(weightTextField)
        
        imageView.image = UIImage.image
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
}

