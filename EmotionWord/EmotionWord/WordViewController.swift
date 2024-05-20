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
    @IBOutlet var wordButtons: [UIButton]!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    
    let wordList = ["무물보", "스불재", "디토합니다", "중꺾마", "자만추", "별다줄", "분좋카", "700", "완내스", "억텐"]
    let resultList = ["무엇이든 물어보세요", "스스로 불러온 재앙", "동의합니다", "중요한건 꺾이지 않는 마음", "자연스러운 만남 추구", "별걸 다 줄이네", "분위기 좋은 카페", "귀여워", "완전 내 스타일", "억지 텐션"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField()
        setSearchButton()
        
        for i in 0..<5 {
            setWordButton(wordButtons[i], title: wordList[i])
        }
        
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
        
        if let index = wordList.firstIndex(of: search) {
            resultLabel.text = resultList[index]
        } else {
            resultLabel.text = "검색 결과가 없습니다."
        }
        
        view.endEditing(true)
    }
    
    @IBAction func wordBtnDidTapped(_ sender: UIButton) {
        let word = sender.titleLabel?.text ?? ""
        let index = wordList.firstIndex(of: word) ?? 0
        
        searchTextField.text = word
        resultLabel.text = resultList[index]
        
        view.endEditing(true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
