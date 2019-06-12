//
//  BaseFuncViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/14.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import ContactsUI
class BaseFuncViewController: BaseSwiftViewController {

    private lazy var contactTool : ContactTool = {
        let contactTool = ContactTool()
        contactTool.currentViewController = self
        return contactTool
    }()
    
    private lazy var firstButton : UIButton = {
        let firstButton = UIButton(title: "获取通讯录", frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 44), corner: KBtnCornerRadius)
        firstButton.addTarget(self, action: #selector(clickFirstButton), for: .touchUpInside)
        return firstButton
    }()
    
    private lazy var secondButton : UIButton = {
        let secondButton = UIButton(title: "获取单个通讯录", frame: CGRect(x: 20, y: 250, width: kScreenW - 40, height: 44), corner: KBtnCornerRadius)
        secondButton.addTarget(self, action: #selector(clickSecondButton), for: .touchUpInside)
        return secondButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func setupUI() {
        super.setupUI()
        title = "测试基本类型"
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        loadDataFinished()
    }
}

extension BaseFuncViewController {

    @objc func clickFirstButton() {
        contactTool.getAllContacts { (contacts) in
            print("contacts\(contacts)")
        }
    }
    
    @objc func clickSecondButton() {
        contactTool.getContectMessage { (name, phone) in
            print("+++++++++name\(name),phone\(phone)")
        }
    }
}

