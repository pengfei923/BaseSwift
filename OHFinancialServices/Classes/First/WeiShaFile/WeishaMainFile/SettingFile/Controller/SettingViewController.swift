//
//  SettingViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class SettingViewController: BaseSwiftViewController {

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frameSelf: UIView.fullScreenBounds(), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingNormalCell", bundle: nil), forCellReuseIdentifier: "SettingNormalCell")
        return tableView
    }()
    
    private lazy var backBtn : UIButton = {
        let backBtn = UIButton(title: "安全退出", frame: CGRect(x: 20, y: 40, width: kScreenW - 40, height: 44), corner: KBtnCornerRadius)
        backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
        return backBtn
    }()
    
    private lazy var loginInfo : LoginInfo = LoginInfo()
    private lazy var userInfo : UserInfo = UserInfo()
    
    private lazy var footerView : UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
        return footerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人中心"
        setupUI()
        dealClick()
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(tableView)
        
        let yuan : String = "3".yuan
        
        print("这里是我返回的信息，我看下返回的正确不\(yuan)")
        
    }

}

extension SettingViewController {
    private func dealClick() {
        
    }
    @objc func clickBackBtn() {
        if userInfo.phone!.isEmpty {
            infoNotice("您暂时未登录", autoClear: true)
            return
        }
        loginInfo.removeSavedUserInfo()
        let mainVC = MainTabbarViewController()
        self.present(mainVC, animated: true, completion: nil)
    }
}

extension SettingViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingNormalCell", for: indexPath) as! SettingNormalCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.leftLabel.text = "安全中心"
            }
            if indexPath.row == 1 {
                cell.leftLabel.text = "公司介绍"
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.leftLabel.text = "清除缓存"
                cell.rightLabel.text = "当前缓存\(String.getCacheSize())" + "M"
            }
            if indexPath.row == 1 {
                cell.selectionStyle = .none
                cell.leftLabel.text = "当前版本"
                cell.rightLabel.text = "当前版本: \(String.getVersion())"
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                String.clearCache()
            }else if indexPath.row == 1 {
                
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1{
            footerView.addSubview(backBtn)
            return footerView
        }else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else {
            return 100
        }
    }
}

extension Double {
    var km : Double {return self * 1_000.0}
    var m : Double {return self}
    var cm : Double {return self / 100.0}
    var mm : Double {return self / 1_000.0}
    var ft : Double {return self / 3.28084}
}

extension String {
    var yuan : String {return self + "元"}
}
