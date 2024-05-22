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
    @IBOutlet var resetButton: UIButton!
    
    let emotions = ["행복해", "사랑해", "좋아해", "화가나", "지루해", "안심해", "당황해", "실망해", "속상해"]
    var emotionCount = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emotionCount = getCount()
        
        for i in 0..<9 {
            setButtonUI(emotionButtons[i], num: i)
            setLabelUI(emotionLabels[i], title: emotions[i], count: emotionCount[i])
        }
        
        resetButton.setTitle("Reset", for: .normal)
    }

    func setLabelUI(_ label: UILabel, title: String, count: Int) {
        label.text = "\(title) \(count)"
        label.textAlignment = .center
    }
    
    func setButtonUI(_ button: UIButton, num: Int) {
        let imageName = "slime\(num + 1)"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setTitle("", for: .normal)
    }
    
    func setCount() {
        UserDefaults.standard.setValue(emotionCount, forKey: "EmotionCount")
    }
    
    func getCount() -> [Int] {
        guard let array = UserDefaults.standard.array(forKey: "EmotionCount") as? [Int] else {
            
            return [0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
        return array
    }
    
    @IBAction func slimeDidTapped(_ sender: UIButton) {
        let index = sender.tag
        emotionCount[index] += 1
        emotionLabels[index].text = "\(emotions[index]) \(emotionCount[index])"
        setCount()
    }
    
    @IBAction func resetButtonDidTap(_ sender: UIButton) {
        let initCount = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        for i in 0..<9 {
            emotionLabels[i].text = "\(emotions[i]) \(initCount[i])"
        }
        
        UserDefaults.standard.setValue(initCount, forKey: "EmotionCount")
    }
}

