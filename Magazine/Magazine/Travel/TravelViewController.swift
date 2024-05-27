//
//  TravelViewController.swift
//  Magazine
//
//  Created by 아라 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var recommendTableView: UITableView!
    
    let list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        
        let travelXib = UINib(nibName: "TravelTableViewCell", bundle: nil)
        let adXib = UINib(nibName: "AdTableViewCell", bundle: nil)
        
        recommendTableView.register(travelXib, forCellReuseIdentifier: "TravelTableViewCell")
        recommendTableView.register(adXib, forCellReuseIdentifier: "AdTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        
        if data.ad {
            let cell = recommendTableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = recommendTableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
            
            cell.configureCell(data: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isAd = list[indexPath.row].ad
        
        return isAd ? 80 : 120
    }
}
