//
//  HomeViewController.swift
//  Netflix
//
//  Created by 아라 on 5/16/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var mainPosterImgView: UIImageView!
    @IBOutlet var posterCategoryLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var risingContent: UILabel!
    @IBOutlet var firstPosterImgView: UIImageView!
    @IBOutlet var secondPosterImgView: UIImageView!
    @IBOutlet var thirdPosterImgView: UIImageView!
    @IBOutlet var top10ImageView: UIImageView!
    @IBOutlet var newEpisodeLabel: UILabel!
    @IBOutlet var watchLabel: UILabel!
    
    @IBOutlet var postImageView: [UIImageView]!
    
    var posters = ["명량", "더퍼스트슬램덩크", "알라딘", "아바타물의길"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterCategoryLabel.text = "응원하고픈 . 흥미진진 . 사극 . 전투 . 한국작품"
        posterCategoryLabel.textColor = .white
        posterCategoryLabel.font = .systemFont(ofSize: 12)
        
        playButton.setImage(UIImage.playNormal, for: .normal)
        playButton.setTitle("", for: .normal)
        playButton.setImage(UIImage.playHighlighted, for: .highlighted)
        playButton.setTitle("", for: .highlighted)
        
        likeButton.setTitle("내가 찜한 리스트", for: .normal)
        likeButton.setTitleColor(.white, for: .normal)
        likeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        likeButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        likeButton.tintColor = .white
        likeButton.backgroundColor = .gray
        likeButton.layer.cornerRadius = 7
        
        risingContent.text = "지금 뜨는 콘텐츠"
        risingContent.textColor = .label
        risingContent.font = .systemFont(ofSize: 22, weight: .heavy)
        
        for i in 0..<postImageView.count {
            setPostUI(postImageView[i], image: UIImage(named: posters[i])!, cornerRadius: i == 0 ? 10 : 5)
        }
        
        top10ImageView.image = UIImage.top10Badge
        top10ImageView.contentMode = .scaleAspectFit
        
        newEpisodeLabel.text = " 지금 시청하기 "
        newEpisodeLabel.textColor = .black
        newEpisodeLabel.textAlignment = .center
        newEpisodeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        newEpisodeLabel.backgroundColor = .white
        newEpisodeLabel.layer.cornerRadius = 5
        newEpisodeLabel.layer.borderWidth = 1
        newEpisodeLabel.layer.borderColor = UIColor.black.cgColor
        newEpisodeLabel.clipsToBounds = true
        
        watchLabel.text = "새로운 에피소드"
        watchLabel.textColor = .white
        watchLabel.textAlignment = .center
        watchLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        watchLabel.backgroundColor = .red
        watchLabel.layer.cornerRadius = 5
    }
    
    func setPostUI(_ imageView: UIImageView, image: UIImage, cornerRadius: CGFloat) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        let sufflePoster = posters.shuffled()
        
        mainPosterImgView.image = UIImage(named: sufflePoster[0])
        firstPosterImgView.image = UIImage(named: sufflePoster[1])
        secondPosterImgView.image = UIImage(named: sufflePoster[2])
        thirdPosterImgView.image = UIImage(named: sufflePoster[3])
        
        [top10ImageView, newEpisodeLabel, watchLabel].forEach { view in
            let randomNum = Int.random(in: 1...100)
            view.isHidden = randomNum % 2 == 0
        }
    }
}
