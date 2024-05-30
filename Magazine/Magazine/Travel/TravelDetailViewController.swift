//
//  TrableDetailViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit
import Kingfisher

class TravelDetailViewController: UIViewController {
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var travel: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton
        
        configureLayout()
        configuration(data: travel)
    }
    
    func configuration(data: Travel?) {
        guard let data = data, let imageString = data.travel_image, let detail = data.description, let like = data.like  else { return }
        navigationItem.title = data.title
        travelImageView.kf.setImage(with: URL(string: imageString)!)
        detailLabel.text = detail
        likeButton.setImage(UIImage(systemName: like ? "heart.fill" : "heart"), for: .normal)
    }
    
    func configureLayout() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.layer.cornerRadius = 12
        detailLabel.font = .systemFont(ofSize: 17)
        detailLabel.numberOfLines = 0
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .systemPink.withAlphaComponent(0.7)
    }
    
    @objc func popToPreviousView() {
        navigationController?.popViewController(animated: true)
    }
}
