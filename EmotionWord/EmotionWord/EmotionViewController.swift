//
//  ViewController.swift
//  EmotionWord
//
//  Created by 아라 on 5/19/24.
//

import UIKit

class EmotionViewController: UIViewController {
    @IBOutlet var emotionButtons: [UIButton]!
    @IBOutlet var emotionLabels: [UILabel]!
    
    let emotions = ["행복해", "사랑해", "좋아해", "화가나", "지루해", "안심해", "당황해", "실망해", "속상해"]
    var emotionCount = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<9 {
            setButtonUI(emotionButtons[i], num: i)
            setLabelUI(emotionLabels[i], title: emotions[i])
        }
    }

    func setLabelUI(_ label: UILabel, title: String) {
        label.text = "\(title) 0"
        label.textAlignment = .center
    }
    
    func setButtonUI(_ button: UIButton, num: Int) {
        let imageName = "slime\(num + 1)"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle("", for: .normal)
    }
    
    @IBAction func slimeDidTapped(_ sender: UIButton) {
        let index = sender.tag
        emotionCount[index] += 1
        emotionLabels[index].text = "\(emotions[index]) \(emotionCount[index])"
    }
}

