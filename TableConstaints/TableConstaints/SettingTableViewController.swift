//
//  SettingTableViewController.swift
//  TableConstaints
//
//  Created by 아라 on 5/23/24.
//

import UIKit

enum Option: Int, CaseIterable {
    case whole
    case personal
    case others
    
    var mainOption: String {
        switch self {
        case .whole: "전체 설정"
        case .personal: "개인 설정"
        case .others: "기타"
        }
    }
    
    var subOption: [String] {
        switch self {
        case .whole: ["공지사항", "실험실", "버전 정보"]
        case .personal: ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others: ["고객센터/도움말"]
        }
    }
}

class SettingTableViewController: UITableViewController {
    let wholeList = ["공지사항", "실험실", "버전 정보"]
    let personalList = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return Option.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Option.allCases[section].subOption.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Option.allCases[section].mainOption
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wholeCell")!
        
        cell.textLabel?.text = Option.allCases[indexPath.section].subOption[indexPath.row]
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20.0
    }
}
