//
//  FirstViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import Presentr

class FirstViewController: BaseSwiftViewController {
    
    private lazy var viewModel : FirstViewModel = FirstViewModel()
    
    private lazy var mainTopView : HSMainTopView = HSMainTopView()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frameSelf: CGRect(x: 0, y: KTopDistance, width: kScreenW, height: kScreenH - KTopDistance - KSafeScreenBottomMargin), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "PersonNormalTableCell", bundle: nil), forCellReuseIdentifier: "PersonNormalTableCell")
        return tableView
    }()
    
    private lazy var tap : UITapGestureRecognizer = UITapGestureRecognizer()
    private lazy var imageTap : UITapGestureRecognizer = UITapGestureRecognizer()
    private lazy var helper : DeviceAuthorizationHelper = {
        let helper = DeviceAuthorizationHelper()
        helper.superViewController = self
        helper.pickerTitle = "选择照片"
        helper.allowsEditing = true
        return helper
    }()
    private lazy var footerLabel : UILabel = {
        let footerLable = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 60))
        footerLable.textAlignment = NSTextAlignment.center
        footerLable.textColor = UIColor.Gray_102()
        footerLable.text = "-红上旗下  品质保证-"
        return footerLable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDataFinished()
        clickIndexPahtItem()
        
        let money = "123456.2"
        print(money.addMicrometerLevel())
        
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        isShowNavigationBar = true
        mainTopView = HSMainTopView.setMainTopView()
        automaticallyAdjustsScrollViewInsets = true
        tableView.tableHeaderView = mainTopView
        view.addSubview(tableView)
        
        let settingItem = UIBarButtonItem(imageName: "setting", highImageImage: "", size: CGSize(width: 30, height: 44),target: self, action: #selector(clickSettingItem))
        let listeningTtem = UIBarButtonItem(imageName: "customer_center", highImageImage: "", size: CGSize(width: 30, height: 44),target: self,action: #selector(clickListeningItem))
        self.navigationItem.rightBarButtonItems = [settingItem,listeningTtem]
        
    }
}
extension FirstViewController {
    private func clickIndexPahtItem() {
        mainTopView.clickIndexPath { indexPath in
            if indexPath.item == 0 {
                print("点击近7日按钮")
            }
            if indexPath.item == 1 {
                print("点击往来记录按钮")
            }
            if indexPath.item == 2 {
               print("点击分期计划按钮")
            }
        }
        mainTopView.userNameLabel.addGestureRecognizer(tap)
        mainTopView.iconImageView.addGestureRecognizer(imageTap)
        tap.addTarget(self, action: #selector(clickUserNameLabel))
        imageTap.addTarget(self, action: #selector(clickIconImage))
    }
    
    @objc func clickUserNameLabel() {
        print("clickNameLabel")
        let vc = LoginViewController()
        let navi = UINavigationController(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }
    
    @objc func clickIconImage() {
        print("点击了头像按钮")
        
        helper.photoSelection { (image, bool) in
            if bool == false {
                let dataImage = UIImage.jpegData(image.reSizeImage(reSize: CGSize(width: 100, height: 100)))
                print("\(String(describing: dataImage))")
            }else {
                print("")
            }
            
        }
    }
    
    @objc func clickSettingItem() {
        let vc = SettingViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickListeningItem() {
        print("点击了用户昵称按钮");
    }
}

extension FirstViewController {
    @objc func clickSureButton() {
        print("点击了上传头像")
        
        viewModel.reloadData { [weak self](userModel) in
            self!.loadDataFinished()

        }
    }
    
}

extension FirstViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonNormalTableCell", for: indexPath) as! PersonNormalTableCell
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0 {
            cell.personListIcon.image = UIImage(named: "person_bank")
            cell.personListText.text = "银行卡"
        }else {
            if indexPath.row == 0 {
                cell.personListIcon.image = UIImage(named: "person_applyRecord")
                cell.personListText.text = "列表练习"
            }
            if indexPath.row == 1 {
                cell.personListIcon.image = UIImage(named: "person_signMsg")
                cell.personListText.text = "签约信息"
            }
            if indexPath.row == 2 {
                cell.personListIcon.image = UIImage(named: "person_balance")
                cell.personListText.text = "资产余额"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
        }else {
            if indexPath.row == 0 {
                let vc = OHReapyRecondTotalViewController()
                vc.hidesBottomBarWhenPushed = true;
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1 {
                
            }else if indexPath.row == 2 {
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return footerLabel
        }else {
           return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }else {
            return 60
        }
    }
}
