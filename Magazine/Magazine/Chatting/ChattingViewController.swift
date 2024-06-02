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
        
        let personalXib = UINib(nibName: PersonalRoomTableViewCell.identifier, bundle: nil)
        let groupXib = UINib(nibName: GroupRoomTableViewCell.identifier, bundle: nil)
        
        chattingRoomTableView.register(personalXib, forCellReuseIdentifier: PersonalRoomTableViewCell.identifier)
        chattingRoomTableView.register(groupXib, forCellReuseIdentifier: GroupRoomTableViewCell.identifier)
        
        chattingRoomTableView.rowHeight = 80
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = mockChatList[indexPath.row]
        
        if data.chatroomImage.count > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupRoomTableViewCell.identifier, for: indexPath) as! GroupRoomTableViewCell
            
            cell.configureCell(data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalRoomTableViewCell.identifier, for: indexPath) as! PersonalRoomTableViewCell
            
            cell.configureCell(data)
            return cell
        }
    }
}
