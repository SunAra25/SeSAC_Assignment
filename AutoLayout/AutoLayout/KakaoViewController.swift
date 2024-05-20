//
//  ViewController.swift
//  AutoLayout
//
//  Created by 아라 on 5/20/24.
//

import UIKit

class KakaoViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var cancleButton: UIButton!
    @IBOutlet var topButtons: [UIButton]!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var bottomButtons: [UIButton]!
    
    let topButtonTitle = ["선물하기", "송금하기", "설정"]
    let topButtonImage = ["cube.box.fill", "qrcode", "gearshape"]
    let bottomButtonTitle = ["나와의 채팅", "프로필 편집", "카카오스토리"]
    let bottomButtonImage = ["bubble.fill", "pencil", "quote.closing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancleButton.setTitle("", for: .normal)
        cancleButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancleButton.tintColor = .label
        
        for i in 0..<3 {
            setTopBtnUI(topButtons[i], image: UIImage(systemName: topButtonImage[i]))
            
            setBottomBtnUI(bottomButtons[i], image: UIImage(systemName: bottomButtonImage[i]), title: bottomButtonTitle[i])
        }
    }
    
    func setTopBtnUI(_ button: UIButton, image: UIImage?) {
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .label
    }
    
    func setBottomBtnUI(_ button: UIButton, image: UIImage?, title: String) {
        var configuration = UIButton.Configuration.plain()
        var attribute = AttributedString.init(title)
        attribute.font = .systemFont(ofSize: 11)
        
        configuration.attributedTitle = attribute
        configuration.image = image
        configuration.baseForegroundColor = .label
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        
        button.configuration = configuration
        
    }
}
