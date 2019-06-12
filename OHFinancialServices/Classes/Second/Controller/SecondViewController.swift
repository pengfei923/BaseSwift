//
//  SecondViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SecondViewController: BaseSwiftViewController {

    lazy var secondViewModel : SecondViewModel = SecondViewModel()
    
    lazy var dataArray : [SecondModel] = [SecondModel]()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frameSelf: UIView.fullScreenBounds(), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SecondNormalCell", bundle: nil), forCellReuseIdentifier: "SecondNormalCell")
        return tableView
    }()
    
    lazy var registerButton : UIButton = {
        let registerButton = UIButton(title: "注册", frame: CGRect(x: 20, y: 300, width: kScreenW - 40, height: 44), corner: 5)
        registerButton.addTarget(self, action: #selector(clickRegisterButton), for: .touchUpInside)
        return registerButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
        refreshUI()
        
//        view.addSubview(registerButton)
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationItem.title = "还款"
        creatTableView()
        
        testView()
    }
    
    deinit {
        tableView.removeFromSuperview()
    }
}

extension SecondViewController {
    private func refreshUI() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.reloadData()
            self.tableView.mj_header.endRefreshing()
        })
    }
}

extension SecondViewController {
    private func creatTableView() {
        self.view.addSubview(tableView)
        
    }
    
}

extension SecondViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondNormalCell", for: indexPath) as! SecondNormalCell
        let data = self.dataArray[indexPath.row]
        cell.titleLabel.text = data.prodName
        cell.leftTitleLabel.text = data.rateDesc
        cell.rightTitleLabel.text = "\(data.amtlimit)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SecondViewController {
    func reloadData() {
        secondViewModel.reloadData { [weak self](secondModel) in
            self?.dataArray = secondModel
            self?.loadDataFinished()
            self?.tableView.reloadData()
        }
    }
}


//MARK: -这里是写测试数据的地方
extension SecondViewController {
    func testView() {
        
    }
    
    @objc func clickRegisterButton() {
        let vc = RegisterViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
