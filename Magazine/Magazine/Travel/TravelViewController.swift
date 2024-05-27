//
//  TravelViewController.swift
//  Magazine
//
//  Created by 아라 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var recommendTableView: UITableView!
    
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendTableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        
        return cell
    }
}
