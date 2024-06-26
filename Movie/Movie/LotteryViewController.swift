//
//  LotteryViewController.swift
//  Movie
//
//  Created by 아라 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit

struct Lotto: Decodable {
    let drwNo: Int
    let drwNoDate: String
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

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
    
    let lottoColor: [UIColor] = [
            .orange.withAlphaComponent(0.7),
            .blue.withAlphaComponent(0.7),
            .red.withAlphaComponent(0.7),
            .gray.withAlphaComponent(0.7),
            .green.withAlphaComponent(0.7)]
    
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
        
        callRequest(lottoRound)
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
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
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
    
    func callRequest(_ round: Int) {
        let url = APIURL.lottoURL + "\(round)"
        AF.request(url).responseDecodable(of: Lotto.self) { [weak self] response in
            guard let self else { return }
            
            switch response.result {
            case .success(let value):
                textField.text = "\(value.drwNo)"
                roundLabel.text = "\(value.drwNo)회 당첨 결과"
                dateLabel.text = value.drwNoDate + " 추첨"
                firstNumberLabel.text = value.drwtNo1.formatted()
                secondNumberLabel.text = value.drwtNo2.formatted()
                thirdNumberLabel.text = value.drwtNo3.formatted()
                fourthNumberLabel.text = value.drwtNo4.formatted()
                fifthNumberLabel.text = value.drwtNo5.formatted()
                sixthNumberLabel.text = value.drwtNo6.formatted()
                bonusNumberLabel.text = value.bnusNo.formatted()
                
                [firstNumberLabel, secondNumberLabel, thirdNumberLabel, fourthNumberLabel, fifthNumberLabel, sixthNumberLabel, bonusNumberLabel].forEach {
                    guard let num = Int($0.text!) else { return }
                    
                    $0.backgroundColor = self.lottoColor[num/10]
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottoRound
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let round = Array(stride(from: lottoRound, through: 1, by: -1))
        return "\(round[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let round = lottoRound - row
        callRequest(round)
    }
}
