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
    @IBOutlet var sendButton: UIButton!
    
    let placeholder = "메세지를 입력하세요"
    var naviTitle = ""
    var chatData = ChatRoom(chatroomId: 0, chatroomImage: [], chatroomName: "", chatList: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureButton()
        configureTableView()
        configureTextView()
        
        scrollToBotton()
    }
    
    func configureNavigation() {
        navigationItem.title = naviTitle
        
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popToPreviousView))
        backbutton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backbutton
    }
    
    func configureButton() {
        sendButton.setTitle("", for: .normal)
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.tintColor = .darkGray
        sendButton.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
    }
    
    func configureTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        let memberXib = UINib(nibName: MemberChattingTableViewCell.identifier, bundle: nil)
        let myXib = UINib(nibName: MyChattingTableViewCell.identifier, bundle: nil)
        
        chatTableView.register(memberXib, forCellReuseIdentifier: MemberChattingTableViewCell.identifier)
        chatTableView.register(myXib, forCellReuseIdentifier: MyChattingTableViewCell.identifier)
        
        chatTableView.separatorStyle = .none
    }
    
    func configureTextView() {
        messageTextView.delegate = self
        
        messageTextView.text = placeholder
        messageTextView.textColor = .systemGray3
        messageTextView.font = .systemFont(ofSize: 14)
        
        messageTextView.backgroundColor = .systemGray6
        messageTextView.layer.cornerRadius = 12
        messageTextView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        messageTextView.isScrollEnabled = false
    }
    
    func scrollToBotton() {
        let index = IndexPath(row: chatData.chatList.count - 1, section: 0)
        chatTableView.scrollToRow(at: index, at: .bottom, animated: false)
    }
    
    @objc func sendButtonDidTap() {
        guard messageTextView.textColor != .systemGray3 else { return }
        
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: date)
        
        chatData.chatList.append(Chat(user: .user, date: dateString, message: messageTextView.text))

        messageTextView.text = ""
        
        view.endEditing(true)
        
        chatTableView.reloadData()
        scrollToBotton()
    }
    
    @objc func popToPreviousView() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray3 {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .systemGray3
            textViewDidChange(textView)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        let isMaxHeight = estimatedSize.height >= 80
        
        guard isMaxHeight != textView.isScrollEnabled else { return }
        textView.isScrollEnabled = isMaxHeight
        textView.reloadInputViews()
        textView.setNeedsUpdateConstraints()
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
