//
//  CityInfoViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}

extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath)
        
        return cell
    }
}
