//
//  ChatRoomViewController.swift
//  Magazine
//
//  Created by 아라 on 6/2/24.
//

import UIKit

class ChatRoomViewController: UIViewController {
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextView: UITextView!
    
    let placeholder = "메세지를 입력하세요"
    var naviTitle = ""
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: [], chatroomName: "", chatList: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        configureTextView()
    }
    
    func configureNavigation() {
        navigationItem.title = naviTitle
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton
    }
    
    func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        let memberXib = UINib(nibName: MemberChattingTableViewCell.identifier, bundle: nil)
        let myXib = UINib(nibName: MyChattingTableViewCell.identifier, bundle: nil)
        
        chatTableView.register(memberXib, forCellReuseIdentifier: MemberChattingTableViewCell.identifier)
        chatTableView.register(myXib, forCellReuseIdentifier: MyChattingTableViewCell.identifier)
    }
    
    func configureTextView() {
        messageTextView.delegate = self
        
        messageTextView.text = placeholder
        messageTextView.textColor = .darkGray
        messageTextView.font = .systemFont(ofSize: 14)
        
        messageTextView.backgroundColor = .systemGray6
        messageTextView.layer.cornerRadius = 12
        messageTextView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        messageTextView.isScrollEnabled = false
    }
    
    @objc func popToPreviousView() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .darkGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .darkGray
        }
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatData.chatList[indexPath.row]
        if chat.user != .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: MemberChattingTableViewCell.identifier, for: indexPath) as! MemberChattingTableViewCell
            
            cell.configureCell(chat)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChattingTableViewCell.identifier, for: indexPath) as! MyChattingTableViewCell
            
            cell.configureCell(chat)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
