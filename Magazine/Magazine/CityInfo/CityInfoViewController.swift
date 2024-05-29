//
//  CityInfoViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    @IBOutlet var cityTableView: UITableView!
    
    let list = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        setTableView()
    }
    
    func setTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        cityTableView.rowHeight = 150
    }
}

extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        let data = list[indexPath.row]
        
        cell.configureCell(data)
        
        return cell
    }
}
