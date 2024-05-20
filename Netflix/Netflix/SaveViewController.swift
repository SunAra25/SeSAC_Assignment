//
//  SaveViewController.swift
//  Netflix
//
//  Created by 아라 on 5/16/24.
//

import UIKit

class SaveViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "\'나만의 자동 저장\' 기능"
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 36, weight: .heavy)
        
        messageLabel.text = """
        취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다.
        디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요.
        """
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        contentImageView.image = UIImage.dummy
        contentImageView.contentMode = .scaleAspectFill
        
        settingButton.setTitle("설정하기", for: .normal)
        settingButton.setTitleColor(.white, for: .normal)
        settingButton.backgroundColor = .blue
        settingButton.layer.cornerRadius = 5
        
        searchButton.setTitle("저장 가능한 콘텐츠 살펴보기", for: .normal)
        searchButton.setTitleColor(.systemBackground, for: .normal)
        searchButton.backgroundColor = .label
        searchButton.layer.cornerRadius = 5
    }

}
