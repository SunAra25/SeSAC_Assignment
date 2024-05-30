//
//  CityInfoViewController.swift
//  Magazine
//
//  Created by 아라 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    @IBOutlet var cityTableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    let list = CityInfo.city
    var filterList: [City] = []
    
    let items = ["전체", "국내", "해외"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        
        filterList = list
        
        setTableView()
        setSegment()
    }
    
    func setTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        cityTableView.rowHeight = 150
    }
    
    func setSegment() {
        segmentedControl.removeAllSegments()
        
        let actions = [showAllList, filterDomestic, filterOverseas]
        
        for idx in 0..<items.count {
            segmentedControl.insertSegment(withTitle: items[idx], at: idx, animated: true)
        }
        
        segmentedControl.addTarget(self, action: #selector(segmentBtnDidTap(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
}

extension CityInfoViewController {
    func showAllList() {
        filterList = list
    }
    
    func filterDomestic() {
        filterList = list.filter { $0.domestic_travel == true }
        cityTableView.reloadData()
    }
    
    func filterOverseas() {
        filterList = list.filter { $0.domestic_travel == false }
        cityTableView.reloadData()
    }
    
    @objc func segmentBtnDidTap(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0: showAllList()
        case 1: filterDomestic()
        case 2: filterOverseas()
        default: break
        }
    }
}

extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        let data = filterList[indexPath.row]
        
        cell.configureCell(data)
        
        return cell
    }
}
