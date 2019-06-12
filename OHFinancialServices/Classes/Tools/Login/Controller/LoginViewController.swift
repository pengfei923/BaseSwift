//
//  LoginViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit


class LoginViewController: BaseSwiftViewController {
    
    private var loginView : LoginNormalView!
    
    private lazy var loginViewModel : LoginViewModel = LoginViewModel()
    private lazy var userInfo : UserInfo = UserInfo()
    private lazy var loginInfo : LoginInfo = LoginInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setupUI()
        navigationItem.title = "登陆"
        loginUI()
        
    }
    // 重写baseView的UI
    override func setupUI() {
        super.setupUI()

        loadDataFinished()
        
        loginView = LoginNormalView.setupLoginNormalView()
        loginView.sureButton .addTarget(self, action: #selector(clickSureButton), for: .touchUpInside)
        self.view.addSubview(loginView)
    }
    
    @objc func clickSureButton() {
        requestData()
        
        
    }
}

extension LoginViewController {
    private func loginUI() {
        let deleteBtn = UIBarButtonItem(title: "取消", target: self, action: #selector(clickDeleteBtn))
        navigationItem.rightBarButtonItem = deleteBtn
    }
    
    @objc func clickDeleteBtn() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController {
    private func requestData() {
        loginViewModel.reloadData(phone: loginView.phoneTextField.text!, pwd: loginView.pwdTextField.text!) { [weak self](model) in
            print("这里是我返回的银行卡信息\(model.bankpwd ?? "")")
            self?.userInfo.custname = model.custname ?? ""
            self?.userInfo.paperid = model.paperid ?? ""
            self?.userInfo.phone = model.phone ?? ""
            self?.userInfo.id = model.id ?? ""
            self?.userInfo.photopath = model.photopath
            self?.loginInfo.saveUserInfo(userInfo: self!.userInfo)
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.jumpToMainVC()
            
            self?.hidesKeyBoard()
        }
    }
}
