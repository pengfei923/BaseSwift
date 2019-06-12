//
//  NewRegisterViewController.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/17.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
class NewRegisterViewController: BaseViewController {

    private let disposeBag = DisposeBag()
    
    private lazy var userTextField : UITextField = {
        let userTextField = UITextField(placeHolder: "用户名", frame: CGRect(x: 20, y: 100, width: kScreenW - 40, height: 44))
        return userTextField
    }()
    
    private lazy var pwdTextField : UITextField = {
        let pwdTextField = UITextField(placeHolder: "密码", frame: CGRect(x: 20, y: 180, width: kScreenW - 40, height: 44))
        return pwdTextField
    }()
    
    private lazy var surePwdTextField : UITextField = {
        let surePwdTextField = UITextField(placeHolder: "请确认密码", frame: CGRect(x: 20, y: 260, width: kScreenW - 40, height: 44))
        return surePwdTextField
    }()
    
    private lazy var sureBtn : UIButton = {
       let sureBtn = UIButton(title: "确定", frame: CGRect(x: 20, y: 340, width: kScreenW - 40, height: 44), corner: 5)
        return sureBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        processintLogic()
        
    }
    
    override func setupUI() {
        super.setupUI()
        loadDataFinished()
        title = "注册界面"
        self.view.addSubview(userTextField)
        self.view.addSubview(pwdTextField)
        self.view.addSubview(surePwdTextField)
        self.view.addSubview(sureBtn)
    }

}

extension NewRegisterViewController {
    private func processintLogic() {
        userTextField.rx.text.orEmpty.subscribe(onNext: { (text) in
            print("返回来的数据信息:\(text)")
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
//        pwdTextField.rx.text.orEmpty.map{$0.count > 5 && $0.count < 21}.subscribe(onNext: {[weak self] (bool) in
//            self?.sureBtn.isEnabled = bool
//            self?.sureBtn.backgroundColor = bool == true ? UIColor.red : UIColor.gray
//        }, onError: { (error) in
//
//        }).disposed(by: disposeBag)
        
        let userField = userTextField.rx.text.orEmpty.map{
            $0.count > 5 && $0.count < 10
        }
        
        let pwdField = pwdTextField.rx.text.orEmpty.map{
            $0.count > 10 && $0.count < 21
        }
        Observable.combineLatest(userField,pwdField){
            $0&&$1
            }.subscribe(onNext: { [weak self](bool) in
                self?.sureBtn.isEnabled = bool
                self?.sureBtn.backgroundColor = bool == true ? UIColor.red : UIColor.gray
                }, onError: { (error) in
            }).disposed(by: disposeBag)
    }
}
