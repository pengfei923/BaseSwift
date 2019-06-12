//
//  RegisterViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class RegisterViewController: BaseSwiftViewController {

    private var registerView : RegisterNormalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDataFinished()
    }
    
    // 重写baseView的UI
    override func setupUI() {
        super.setupUI()
        title = "注册"
        registerView = RegisterNormalView.setupRegisterNormalView()
        registerView.sureButton.addTarget(self, action: #selector(clickRegisterSureBtn), for: .touchUpInside)
        self.view.addSubview(registerView)
    }
}

extension RegisterViewController {
    @objc func clickRegisterSureBtn() {
        let vc = ThirdViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
