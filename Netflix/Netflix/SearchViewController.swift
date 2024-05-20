//
//  SearchViewController.swift
//  Netflix
//
//  Created by 아라 on 5/16/24.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var releaseButton: UIButton!
    @IBOutlet var papularButton: UIButton!
    @IBOutlet var top10Button: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var capsuleButton: [UIButton]!
    let buttonImage = ["blue", "pink", "turquoise"]
    let buttonTitle = ["공개예정", "모두의 인기 콘텐츠", "TOP 10 시리즈"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.textColor = .black
        searchTextField.font = .systemFont(ofSize: 14)
        searchTextField.placeholder = "게임, 시리즈, 영화를 검색하세요..."
        searchTextField.keyboardType = .default
        
        for (index, button) in capsuleButton.enumerated() {
            setCapsuleBtnUI(button, image: UIImage(named: buttonImage[index]), title: buttonTitle[index])
        }
        
        resultLabel.text = "검색어를 입력해보세요"
        resultLabel.textColor = .label
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 22, weight: .heavy)

        messageLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해보세요"
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 12, weight: .light)
    }
    
    func setCapsuleBtnUI(_ button: UIButton, image: UIImage?, title: String) {
        let backgroundColor: UIColor = button == releaseButton ? .label : .systemBackground
        let tintColor: UIColor = button == releaseButton ? .systemBackground : .label
        
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 11)
        button.tintColor = tintColor
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 18
    }
    
    @IBAction func returnDidTapped(_ sender: UITextField) {
        let result = searchTextField.text ?? ""
        resultLabel.text = "\(result)을/를 검색한 결과입니다."
    }
    
    
    @IBAction func categoryBtnDidTap(_ sender: UIButton) {
        let tag = sender.tag
        
        for i in 0..<capsuleButton.count {
            if tag == i {
                sender.backgroundColor = .label
                sender.tintColor = .systemBackground
                messageLabel.text = "\(buttonTitle[i]) 결과입니다."
            } else {
                capsuleButton[i].backgroundColor = .systemBackground
                capsuleButton[i].tintColor = .label
            }
        }
    }
}
