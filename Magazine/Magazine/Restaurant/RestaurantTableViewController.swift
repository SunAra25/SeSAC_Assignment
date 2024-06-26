//
//  RestaurantTableViewController.swift
//  Magazine
//
//  Created by 아라 on 5/25/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    @IBOutlet var categoryButtons: [UIButton]!
    
    let list = RestaurantList().restaurantArray
    var currentList: [Restaurant] = []
    lazy var categoryList = ["전체"] + Array(Set<String>(self.list.map { $0.category })).sorted { $0 > $1}
       var currentCategoryIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
        
        currentList = list
        
        tableView.rowHeight = 140
        
        for (idx, button) in categoryButtons.enumerated() {
            setButton(button, title: categoryList[idx], fontSize: 11)
            setCapsule(button, cornerRadius: 15)
            if idx == currentCategoryIdx {
                button.backgroundColor = .darkGray
                button.setTitleColor(.white, for: .normal)
            }
            button.tag = idx
            button.addTarget(self, action: #selector(categoryButtonDidTap), for: .touchUpInside)
        }
    }
    
    func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "음식점을 검색해보세요!"
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "문래역 맛집 탐방"
        
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        guard let text = searchController.searchBar.text else { return }
        
        if text.isEmpty {
            currentList = list
        } else {
            let searchList = list.filter { $0.name.contains(text) }
            
            currentList = searchList
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let row = currentList[indexPath.row]
        
        guard let imageURL = URL(string: row.image) else { return cell }
        cell.thumbnailImage.kf.setImage(with: imageURL)
        cell.thumbnailImage.layer.cornerRadius = 10
        cell.thumbnailImage.clipsToBounds = true
        cell.thumbnailImage.contentMode = .scaleAspectFill
        
        setLabel(cell.nameLabel, text: row.name, color: .black, font: .boldSystemFont(ofSize: 16))
        
        cell.categoryLabel.textAlignment = .center
        setLabel(cell.categoryLabel, text: row.category, color: .black, font: .systemFont(ofSize: 12))
        setCapsule(cell.categoryLabel, cornerRadius: 10)
        
        setLabel(cell.addressLabel, text: row.address, color: .darkGray, font: .systemFont(ofSize: 14))
        cell.addressLabel.numberOfLines = 0
        
        setButton(cell.phoneButton, title: row.phoneNumber, fontSize: 15)
        cell.phoneButton.addTarget(self, action: #selector(phoeButtonDidTap), for: .touchUpInside)
        
        setLabel(cell.priceLabel, text: "가격 : \(row.price)", color: .darkGray, font: .systemFont(ofSize: 12))
        
        return cell
    }
    
    func setLabel(_ label: UILabel, text: String, color: UIColor?, font: UIFont?) {
        label.text = text
        label.textColor = color
        label.font = font
    }
    
    func setCapsule(_ view: UIView, cornerRadius: CGFloat) {
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2
        view.clipsToBounds = true
    }
    
    func setButton(_ button: UIButton, title: String, fontSize: CGFloat) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        button.tintColor = .darkGray
    }
    
    @objc func phoeButtonDidTap(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let call = UIAlertAction(title: "통화 \(number)", style: .default)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(call)
        alert.addAction(cancle)
        
        self.present(alert, animated: true)
    }
    
    @objc func categoryButtonDidTap(_ sender: UIButton) {
        let category = categoryList[sender.tag]
        
        currentList = category == "전체" ? list : list.filter { $0.category == category }
        
        for (idx, button) in categoryButtons.enumerated() {
            button.backgroundColor = idx == sender.tag ? .darkGray : .systemGray6
            button.setTitleColor(idx == sender.tag ? .white : .darkGray, for: .normal)
            
        }
        
        tableView.reloadData()
    }
    
    @objc func keyboardDismiss(_ sender: UISearchTextField) {
        view.endEditing(true)
    }
}
