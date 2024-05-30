//
//  TravelViewController.swift
//  Magazine
//
//  Created by 아라 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var recommendTableView: UITableView!
    
    var list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        
        let travelXib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        let adXib = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        
        recommendTableView.register(travelXib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        recommendTableView.register(adXib, forCellReuseIdentifier: AdTableViewCell.identifier)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        
        if data.ad {
            let cell = recommendTableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = recommendTableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
            
            cell.configureCell(data: data, tag: indexPath.row)
            
            cell.saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isAd = list[indexPath.row].ad
        
        return isAd ? 80 : 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        
        let save = UIContextualAction(style: .normal, title: "") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            let isSave = self.list[indexPath.row].like!
            let save = self.list[indexPath.row].save!
            
            self.list[indexPath.row].like!.toggle()
            self.list[indexPath.row].save! = isSave ? save - 1 : save + 1
            
            self.recommendTableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        save.image = UIImage(systemName: data.like! ? "heart.fill" : "heart")
        save.backgroundColor = .systemPink.withAlphaComponent(0.3)
        
        return UISwipeActionsConfiguration(actions:[save])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        if data.ad {
            let vc = sb.instantiateViewController(withIdentifier: "AdDetailVC")
            let nv = UINavigationController(rootViewController: vc)
            
            nv.modalPresentationStyle = .fullScreen
            present(nv, animated: true)
        } else {
            let vc = sb.instantiateViewController(withIdentifier: "TravelDetailVC") as! TravelDetailViewController
            vc.travel = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func saveButtonDidTap(sender: UIButton) {
        guard let current = list[sender.tag].like else { return }
        
        let save = list[sender.tag].save!
        list[sender.tag].save! = current ? save - 1 : save + 1
        list[sender.tag].like!.toggle()
        
        recommendTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
