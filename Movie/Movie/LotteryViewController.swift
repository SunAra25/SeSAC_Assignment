//
//  LotteryViewController.swift
//  Movie
//
//  Created by 아라 on 6/5/24.
//

import UIKit
import SnapKit

class LotteryViewController: UIViewController {
    let textField = UITextField()
    let pickerView = UIPickerView()
    let guideLabel = UILabel()
    let dateLabel = UILabel()
    let underlineView = UIView()
    let roundLabel = UILabel()
    let resultView = UIView()
    let firstNumberLabel = UILabel()
    let secondNumberLabel = UILabel()
    let thirdNumberLabel = UILabel()
    let fourthNumberLabel = UILabel()
    let fifthNumberLabel = UILabel()
    let sixthNumberLabel = UILabel()
    let bonusNumberLabel = UILabel()
    let plusLabel = UILabel()
    let bonusTextLabel = UILabel()
    
    var lottoRound: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let startDate = dateFormatter.date(from: "2002-12-07") else { return 0 }
        let endDate = Date()
        
        let calendar = Calendar.current
        
        let count = calendar.dateComponents([.weekOfYear], from: startDate, to: endDate).weekOfYear ?? 0
        
        return count + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setHierachy()
        setConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        textField.textAlignment = .center
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .semibold)
        textField.inputView = pickerView
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        
        [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, bonusNumberLabel].forEach {
            $0.font = .boldSystemFont(ofSize: 14)
            textField.textAlignment = .center
            $0.textAlignment = .center
            $0.textColor = .white
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.backgroundColor = .blue
            $0.text = "88"
        }
        
        guideLabel.text = "당첨번호 안내"
        guideLabel.textAlignment = .left
        guideLabel.textColor = .black
        guideLabel.font = .systemFont(ofSize: 14)
        
        dateLabel.text = "당첨번호 안내"
        dateLabel.textAlignment = .right
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 12)
        
        underlineView.backgroundColor = .systemGray3
        
        roundLabel.text = "당첨번호 안내"
        roundLabel.textAlignment = .center
        roundLabel.textColor = .black
        roundLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        plusLabel.text = "+"
        plusLabel.textAlignment = .center
        plusLabel.textColor = .black
        plusLabel.font = .boldSystemFont(ofSize: 14)
        
        bonusTextLabel.text = "보너스"
        bonusTextLabel.textAlignment = .center
        bonusTextLabel.textColor = .systemGray
        bonusTextLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    func setHierachy() {
        
    }
    
    func setConstraints() {
        
    }
    
    func callRequest() {
        
    }
}
