//
//  ContactViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/21.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class ContactViewController: BaseSwiftViewController {

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frameSelf: UIView.fullScreenBounds(), style: .grouped)
        tableView.register(UINib(nibName: "SystomContactCell", bundle: nil), forCellReuseIdentifier: "SystomContactCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var contactArray : [[String:Any]]?
    
    typealias contactBlock = ([String:Any])->()
    var block : contactBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
        super.setupUI()
        title = "选择联系人"
        view.addSubview(tableView)
        print("\(contactArray!.count)")
    }
}

extension ContactViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SystomContactCell", for: indexPath) as! SystomContactCell
        let dict = contactArray![indexPath.row]
        cell.leftLabel.text = "\(dict["name"] ?? "联系人\(indexPath.row)")"
        cell.rightLabel.text = "\(dict["phone"] ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.popViewController(animated: true)
        let dict = contactArray![indexPath.row]
        print("这里是我返回的信息\(dict)")
        if let block = self.block {
            block(dict)
        }
    }
    
    func getBlock(block:contactBlock?) {
        self.block = block
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
