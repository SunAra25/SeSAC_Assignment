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
    
    let viewModel = CityInfoViewModel()
    var currentList: [City] = []
    let items = ["전체", "국내", "해외"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        
        setTableView()
        setSegment()
        bindData()
    }
    
    func setTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        cityTableView.rowHeight = 150
    }
    
    func bindData() {
        viewModel.outputShowWholeList.bind { [weak self] list in
            guard let self else { return }
            currentList = list
            cityTableView.reloadData()
        }
        
        viewModel.outputShowDomesticList.bind { [weak self] list in
            guard let self else { return }
            currentList = list
            cityTableView.reloadData()
        }
        
        viewModel.outputShowOverseaList.bind { [weak self] list in
            guard let self else { return }
            currentList = list
            cityTableView.reloadData()
        }
    }
    
    func setSegment() {
        segmentedControl.removeAllSegments()
        
        for idx in 0..<items.count {
            segmentedControl.insertSegment(withTitle: items[idx], at: idx, animated: true)
        }
        
        segmentedControl.addTarget(self, action: #selector(segmentBtnDidTap(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func segmentBtnDidTap(segment: UISegmentedControl) {
         switch segment.selectedSegmentIndex {
         case 0: viewModel.inputWholeTap.value = ()
         case 1: viewModel.inputDomesticTap.value = ()
         case 2: viewModel.inputOverseaTap.value = ()
         default: break
         }
     }
}

extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        let data = currentList[indexPath.row]
        
        cell.configureCell(data)
        
        return cell
    }
}
