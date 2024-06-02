//
//  ChattingViewController.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class ChattingViewController: UIViewController {
    @IBOutlet var chattingRoomTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var filterList : [ChatRoom] = mockChatList {
        didSet {
            chattingRoomTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureSearchBar()
        configureTableView()
    }
    
    func configureNavigation() {
        navigationItem.title = "TRAVEL TALK"
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "친구 이름을 검색해보세요"
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
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = filterList[indexPath.row]
        
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

extension ChattingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        let text = search.lowercased()
        
        var temp: [ChatRoom] = []
        
        for chat in mockChatList {
            if chat.chatroomName.contains(text) || 
                chat.chatList.contains(where: { $0.message.contains(text) || $0.user.rawValue.lowercased().contains(text)}) {
                temp.append(chat)
            }
        }
        
        filterList = temp
        
        view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
        
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterList = mockChatList
        
        view.endEditing(true)
    }
}
