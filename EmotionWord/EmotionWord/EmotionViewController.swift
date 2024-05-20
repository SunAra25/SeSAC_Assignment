//
//  ViewController.swift
//  EmotionWord
//
//  Created by 아라 on 5/19/24.
//

import UIKit

class EmotionViewController: UIViewController {
    @IBOutlet var happyButton: UIButton!
    @IBOutlet var happyLabel: UILabel!
    @IBOutlet var loveButton: UIButton!
    @IBOutlet var loveLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var upsetButton: UIButton!
    @IBOutlet var upsetLabel: UILabel!
    @IBOutlet var boringButton: UIButton!
    @IBOutlet var boringLabel: UILabel!
    @IBOutlet var relifeButton: UIButton!
    @IBOutlet var relifeLabel: UILabel!
    @IBOutlet var panicButton: UIButton!
    @IBOutlet var panicLabel: UILabel!
    @IBOutlet var disappointedButton: UIButton!
    @IBOutlet var disappointedLabel: UILabel!
    @IBOutlet var sadButton: UIButton!
    @IBOutlet var sadLabel: UILabel!
    
    var happyCount = 0
    var loveCount = 0
    var likeCount = 0
    var upsetCount = 0
    var boringCount = 0
    var relifeCount = 0
    var panicCount = 0
    var disappointedCount = 0
    var sadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        happyButton.setImage(UIImage.slime1, for: .normal)
        happyButton.setTitle("", for: .normal)
        
        happyLabel.text = "행복해 0"
        happyLabel.textAlignment = .center
        
        loveButton.setImage(UIImage.slime2, for: .normal)
        loveButton.setTitle("", for: .normal)
        
        loveLabel.text = "사랑해 0"
        loveLabel.textAlignment = .center

        likeButton.setImage(UIImage.slime3, for: .normal)
        likeButton.setTitle("", for: .normal)
        
        likeLabel.text = "좋아해 0"
        likeLabel.textAlignment = .center
        
        upsetButton.setImage(UIImage.slime4, for: .normal)
        upsetButton.setTitle("", for: .normal)
        
        upsetLabel.text = "화가나 0"
        upsetLabel.textAlignment = .center
        
        boringButton.setImage(UIImage.slime5, for: .normal)
        boringButton.setTitle("", for: .normal)
        
        boringLabel.text = "지루해 0"
        boringLabel.textAlignment = .center
        
        relifeButton.setImage(UIImage.slime6, for: .normal)
        relifeButton.setTitle("", for: .normal)
        
        relifeLabel.text = "안심해 0"
        relifeLabel.textAlignment = .center
        
        panicButton.setImage(UIImage.slime7, for: .normal)
        panicButton.setTitle("", for: .normal)
        
        panicLabel.text = "당황해 0"
        panicLabel.textAlignment = .center
        
        disappointedButton.setImage(UIImage.slime8, for: .normal)
        disappointedButton.setTitle("", for: .normal)
        
        disappointedLabel.text = "실망해 0"
        disappointedLabel.textAlignment = .center
        
        sadButton.setImage(UIImage.slime9, for: .normal)
        sadButton.setTitle("슬퍼해", for: .normal)
        
        sadLabel.text = "슬퍼해 0"
        sadLabel.textAlignment = .center
    }

    @IBAction func slimeDidTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            happyCount += 1
            happyLabel.text = "행복해 \(happyCount)"
        case 1:
            loveCount += 1
            loveLabel.text = "사랑해 \(loveCount)"
        case 2:
            likeCount += 1
            likeLabel.text = "좋아해 \(likeCount)"
        case 3:
            upsetCount += 1
            upsetLabel.text = "화가나 \(upsetCount)"
        case 4:
            boringCount += 1
            boringLabel.text = "지루해 \(boringCount)"
        case 5:
            relifeCount += 1
            relifeLabel.text = "안심해 \(relifeCount)"
        case 6:
            panicCount += 1
            panicLabel.text = "당황해 \(panicCount)"
        case 7:
            disappointedCount += 1
            disappointedLabel.text = "실망해 \(disappointedCount)"
        case 8:
            sadCount += 1
            sadLabel.text = "슬퍼해 \(sadCount)"
        default:
            break
        }
    }
}

