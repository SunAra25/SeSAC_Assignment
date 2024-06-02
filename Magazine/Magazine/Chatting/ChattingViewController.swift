//
//  ChattingViewController.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class ChattingViewController: UIViewController {
    @IBOutlet var chattingRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
    }
    
    func configureNavigation() {
        navigationItem.title = "TRAVEL TALK"
    }
    
    func configureTableView() {
        chattingRoomTableView.delegate = self
        chattingRoomTableView.dataSource = self
        
        let xib = UINib(nibName: PersonalRoomTableViewCell.identifier, bundle: nil)
        chattingRoomTableView.register(xib, forCellReuseIdentifier: PersonalRoomTableViewCell.identifier)
        chattingRoomTableView.rowHeight = 80
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalRoomTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
}
