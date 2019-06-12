//
//  LoginNormalView.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginNormalView: UIView {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var sureButton: BaseButton!

    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var noticePhoneNum: UILabel! //提示输入正确的手机号码
    
    class func setupLoginNormalView() -> LoginNormalView {
        let loginView = Bundle.main.loadNibNamed("LoginNormalView", owner: nil, options: nil)?.first as! LoginNormalView
        
        loginView.frame = UIView.fullScreenBounds()
        
        loginView.creatRxSwift()
        
        return loginView
    }
    
}


extension LoginNormalView {
    private func creatRxSwift() {
        
        let phoneIsValid = phoneTextField.rx.text.orEmpty.map { $0.count == 11
        }
        
//        let pwdIsValid = pwdTextField.rx.text.orEmpty.map {
//            $0.count > 11 && $0.count < 22
//        }
        let pwdIsValid = pwdTextField.rx.text.orEmpty.map { (tf) -> Bool in
            tf.count > 6 && tf.count < 22
        }
        
        Observable.combineLatest(phoneIsValid,pwdIsValid) {$0 && $1}.subscribe(onNext: { (bool) in
            self.sureButton.isEnabled = bool
            self.sureButton.backgroundColor = bool == true ? UIColor.red : UIColor.gray
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
     phoneTextField.rx.controlEvent([.editingDidEndOnExit]).asObservable().subscribe(onNext: { (event) in
            self.pwdTextField.becomeFirstResponder()
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
}
