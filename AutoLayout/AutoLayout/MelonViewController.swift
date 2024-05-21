//
//  MelonViewController.swift
//  AutoLayout
//
//  Created by 아라 on 5/21/24.
//

import UIKit

class MelonViewController: UIViewController {
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var labelList: [UILabel]!
    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet var progressView: UIProgressView!
    let buttonImages = ["chevron.down", "ellipsis", "heart", "", "circle.square", "repeat", "shuffle", "list.triangle",  "backward.end.fill", "pause.fill", "forward.end.fill", "speaker.2"]
    let buttonTitles = ["", "", "1001,345", "유사곡", "", "", "", "", "", "", "", ""]
    let labelTexts = ["Welcome to the Show", "Day6", "이것만큼은 맹세할게\n내 전부를 다 바칠게\n네 눈빛 흔들리지 않게\n널 바라보면 서 있을게", "0:04", "1:00"]
    let labelFonts: [UIFont?] = [.systemFont(ofSize: 16, weight: .bold), .systemFont(ofSize: 12), .systemFont(ofSize: 14, weight: .semibold), .systemFont(ofSize: 11, weight: .bold), .systemFont(ofSize: 11)]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleImageView.image = UIImage(systemName: "music.note.list")
        albumImageView.image = UIImage.album
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.layer.cornerRadius = 5
        
        for (index, label) in labelList.enumerated() {
            setLabelUI(label, text: labelTexts[index], font: labelFonts[index])
        }
        
        for (index, button) in buttonList.enumerated() {
            setButtonUI(button, title: buttonTitles[index], image: UIImage(systemName: buttonImages[index]))
        }
        
        progressView.tintColor = .green
    }
    
    func setLabelUI(_ label: UILabel, text: String, font: UIFont?) {
        label.text = text
        label.font = font
        label.textColor = label == labelList[3] ? .green : .white
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    func setButtonUI(_ button: UIButton, title: String, image: UIImage?) {
        button.setTitle( title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(image, for: .normal)
    }
}
