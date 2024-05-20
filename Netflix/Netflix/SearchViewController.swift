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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.textColor = .black
        searchTextField.font = .systemFont(ofSize: 14)
        searchTextField.placeholder = "게임, 시리즈, 영화를 검색하세요..."
        searchTextField.keyboardType = .default
        
        releaseButton.setImage(UIImage.blue.withRenderingMode(.alwaysOriginal), for: .normal)
        // 버튼의 스타일이 default일 때 이미지가 제대로 불러오지 못 함
        // rendering mode를 original로 수정하면 됨
        releaseButton.setTitle("공개예정", for: .normal)
        
        releaseButton.titleLabel?.font = .boldSystemFont(ofSize: 11) // Button Style이 Default일 때만 적용됨
        releaseButton.tintColor = .systemBackground
        releaseButton.backgroundColor = .label
        releaseButton.layer.cornerRadius = 18
        
        /* iOS 15+
        releaseButton.configuration?.baseForegroundColor = .systemBackground
        releaseButton.configuration?.cornerStyle = .capsule
        releaseButton.configuration?.baseBackgroundColor = .label
         */
        papularButton.setImage(UIImage.pink, for: .normal)
        papularButton.setTitle("모두의 인기 콘텐츠", for: .normal)
        papularButton.configuration?.baseForegroundColor = .label
        papularButton.configuration?.cornerStyle = .capsule
        papularButton.configuration?.baseBackgroundColor = .systemBackground
        
        top10Button.setImage(UIImage.turquoise, for: .normal)
        top10Button.setTitle("TOP 10 시리즈", for: .normal)
        top10Button.configuration?.baseForegroundColor = .label
        top10Button.configuration?.cornerStyle = .capsule
        top10Button.configuration?.baseBackgroundColor = .systemBackground
        
        resultLabel.text = "검색어를 입력해보세요"
        resultLabel.textColor = .label
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 22, weight: .heavy)

        messageLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해보세요"
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 12, weight: .light)
    }
    
    @IBAction func returnDidTapped(_ sender: UITextField) {
        let result = searchTextField.text ?? ""
        resultLabel.text = "\(result)을/를 검색한 결과입니다."
    }
    
    
    @IBAction func categoryBtnDidTap(_ sender: UIButton) {
        let tag = sender.tag
        
        switch tag {
        case 0: 
            setRelease()
            messageLabel.text = "공개예정 결과입니다."
        case 1: 
            setPapular()
            messageLabel.text = "인기검색 결과입니다."
        case 2: 
            setTop10()
            messageLabel.text = "Top 10 결과입니다."
        default: break
        }
    }
    
    func setRelease() {
        releaseButton.configuration?.baseForegroundColor = .systemBackground
        releaseButton.configuration?.baseBackgroundColor = .label
        
        papularButton.configuration?.baseForegroundColor = .label
        papularButton.configuration?.baseBackgroundColor = .systemBackground
        
        top10Button.configuration?.baseForegroundColor = .label
        top10Button.configuration?.baseBackgroundColor = .systemBackground
    }
    
    func setPapular() {
        releaseButton.configuration?.baseForegroundColor = .label
        releaseButton.configuration?.baseBackgroundColor = .systemBackground
        
        papularButton.configuration?.baseForegroundColor = .systemBackground
        papularButton.configuration?.baseBackgroundColor = .label
        
        top10Button.configuration?.baseForegroundColor = .label
        top10Button.configuration?.baseBackgroundColor = .systemBackground
    }
    
    func setTop10() {
        releaseButton.configuration?.baseForegroundColor = .label
        releaseButton.configuration?.baseBackgroundColor = .systemBackground
        
        papularButton.configuration?.baseForegroundColor = .label
        papularButton.configuration?.baseBackgroundColor = .systemBackground
        
        top10Button.configuration?.baseForegroundColor = .systemBackground
        top10Button.configuration?.baseBackgroundColor = .label
    }
}
