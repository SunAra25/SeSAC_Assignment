//
//  WordViewController.swift
//  EmotionWord
//
//  Created by 아라 on 5/19/24.
//

import UIKit

class WordViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var word1Button: UIButton!
    @IBOutlet var word2Button: UIButton!
    @IBOutlet var word3Button: UIButton!
    @IBOutlet var word4Button: UIButton!
    @IBOutlet var word5Button: UIButton!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    
    let wordList = ["무물보" : "무엇이든 물어보세요", "스불재" : "스스로 불러온 재앙", "디토합니다" : "동의합니다", "중꺾마" : "중요한건 꺾이지 않는 마음", "자만추" : "자연스러운 만남 추구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        setSearchButton()
        setWordButton(word1Button, title: "무물보")
        setWordButton(word2Button, title: "스불재")
        setWordButton(word3Button, title: "디토합니다")
        setWordButton(word4Button, title: "중꺾마")
        setWordButton(word5Button, title: "자만추")
        setResult()
    }

    func setTextField() {
        searchTextField.layer.borderWidth = 2
        searchTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12.0, height: 0.0))
        searchTextField.leftViewMode = .always
        searchTextField.tintColor = .black
    }
    
    func setSearchButton() {
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    func setWordButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 11)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setResult() {
        backgroundImageView.image = UIImage.background
        backgroundImageView.contentMode = .scaleAspectFill
        
        resultLabel.text = "검색어를 입력해보세요!"
        resultLabel.textAlignment = .center
        resultLabel.textColor = .black
        resultLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    @IBAction func searchWord(_ sender: Any) {
        let search = searchTextField.text ?? ""
        if let result = wordList[search] {
            resultLabel.text = result
        } else {
            resultLabel.text = "검색 결과가 없습니다."
        }
        
        view.endEditing(true)
    }
    
    @IBAction func wordBtnDidTapped(_ sender: UIButton) {
        let word = sender.titleLabel?.text ?? ""
        
        searchTextField.text = word
        resultLabel.text = wordList[word]
        
        view.endEditing(true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
