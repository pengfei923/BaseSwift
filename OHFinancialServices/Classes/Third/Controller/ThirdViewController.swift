//
//  ThirdViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ThirdViewController: BaseSwiftViewController {
    
    let disposed = DisposeBag()
    let userInfo = UserInfo()
    let loginInfo = LoginInfo()
    
    private var bannerView : BannerView?
    
    private lazy var bannerModelView : BannerViewModel = BannerViewModel()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frameSelf: CGRect(x: 0, y: KTopDistance, width: kScreenW, height: kScreenH - KTopDistance - KSafeScreenBottomMargin), style: .grouped)
        tableView.register(UINib(nibName: "SecondNormalCell", bundle: nil), forCellReuseIdentifier: "SecondNormalCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var helper : DeviceAuthorizationHelper = {
        let helper = DeviceAuthorizationHelper()
        helper.superViewController = self
        return helper
    }()
    
    private lazy var dataArray : [String] = ["测试webView","测试登录界面细节","测试bar按钮","测试倒计时按钮","测试保存数据","测试删除数据","测试获取数据","测试二维码的生成","获取定位权限","基础方法的调用","RxSwift使用","内购测试"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
    }
    
    
    override func setupUI() {
        super.setupUI()
        isShowNavigationBar = true
        loadDataFinished()
        setupBannerView()
        loadData()
        
        for (index,value) in dataArray.enumerated() {
            print("\(index)\(value)")
        }
    }

}

extension ThirdViewController {
    private func setupBannerView() {
        bannerView = BannerView.setupBannerView()
        tableView.tableHeaderView = bannerView
        view.addSubview(tableView)
    }
}

extension ThirdViewController {
    private func loadData() {
        bannerModelView.requestBannerModel { [weak self](model) in
            self!.bannerView?.bannerModels = model
        }
    }
}

extension ThirdViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondNormalCell", for: indexPath) as! SecondNormalCell
        cell.leftTitleLabel.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = BaseWebViewController()
            vc.titleStr = "百度Title"
            vc.urlString = "http://www.baidu.com"
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = LoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
//            let vc = SearchViewController()
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3 {
            let vc = RegisterViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4 {
            
            userInfo.custname = "pengfei"
            userInfo.phone = "13002945152"
            
            loginInfo.saveUserInfo(userInfo: userInfo)
        }
        if indexPath.row == 5 {
            loginInfo.removeSavedUserInfo()
        }
        if indexPath.row == 6 {
            print(loginInfo.savedUserInfo()?.custname ?? "用户信息已经删除")
        }
        if indexPath.row == 7 {
            let vc = QRCodeViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.row == 8 {
            let vc = MapViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        if indexPath.row == 9 {
            let vc = BaseFuncViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 10 {
            
            let vc = RxswiftDemoViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row == 11 {
            let vc = ApplyPayViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

class MyPoint {
    var x:Float = 0
    var y:Float = 0
    func setMyPoint(tempX:Float,tempY:Float) {
        x = tempX
        y = tempY
    }
    
    func display() {
        print("(\(x),\(y))")
    }
}

struct mePoint {
    var x:Float = 0
    var y:Float = 0
    mutating func setMyPoint(tempX:Float,tempY:Float) {
        x = tempX
        y = tempY
    }
    
    func medisplay() {
        print("\(x),\(y)")
    }
}



