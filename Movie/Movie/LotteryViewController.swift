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
    
    let lottoColor: [UIColor] = [.yellow, .blue, .red, .gray, .green]
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
        [textField, guideLabel, dateLabel, underlineView, roundLabel, resultView, plusLabel, bonusTextLabel].forEach {
            view.addSubview($0)
        }
        
        [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, bonusNumberLabel].forEach {
            resultView.addSubview($0)
        }
    }
    
    func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(guideLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(1)
        }
        
        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(roundLabel.snp.bottom).offset(12)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(340)
            make.height.equalTo(40)
        }
        
        firstNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.size.equalTo(40)
        }
        
        secondNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstNumberLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        thirdNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondNumberLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        fourthNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdNumberLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        fifthNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(fourthNumberLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        sixthNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(fifthNumberLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.leading.equalTo(sixthNumberLabel.snp.trailing).offset(4)
            make.centerY.equalTo(sixthNumberLabel.snp.centerY)
            make.size.equalTo(32)
        }
        
        bonusNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(plusLabel.snp.trailing).offset(4)
            make.size.equalTo(40)
        }
        
        bonusTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(bonusNumberLabel.snp.centerX)
            make.top.equalTo(bonusNumberLabel.snp.bottom).offset(4)
        }
    }
    
    func dateForLottoRound(_ round: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let startDate = dateFormatter.date(from: "2002-12-07"),
              let date = Calendar.current.date(byAdding: .weekOfYear, value: round - 1, to: startDate) else { return "" }
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func callRequest() {
        
    }
}
