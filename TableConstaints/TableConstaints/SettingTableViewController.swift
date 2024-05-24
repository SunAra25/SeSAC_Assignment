//
//  SettingTableViewController.swift
//  TableConstaints
//
//  Created by 아라 on 5/23/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    let wholeList = ["공지사항", "실험실", "버전 정보"]
    let personalList = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : section == 1 ? 4 : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "전체 설정" : section == 1 ? "개인 설정" : "기타"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wholeCell")!
        var text = ""
        
        switch indexPath.section {
        case 0:
            text = wholeList[indexPath.row]
            print(text)
        case 1:
            text = personalList[indexPath.row]
            print(text)
        case 2:
            text = "고객센터/도움말"
            print(text)
        default:
            break
            
        }
        
        cell.textLabel?.text = text
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20.0
    }
}
