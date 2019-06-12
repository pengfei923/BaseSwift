//
//  RegisterNormalView.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class RegisterNormalView: UIView {

    let disposeBag = DisposeBag()
    let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    
    let countDownStopped = Variable(true)
    let leftTime = Variable(Int(30))
    
    @IBOutlet weak var userTextField: BaseTextField!
    
    @IBOutlet weak var pwdTextField: BaseTextField!
    
    @IBOutlet weak var surePwdTextField: BaseTextField!
    
    @IBOutlet weak var sureButton: BaseButton!
    
    @IBOutlet weak var codeTextField: BaseTextField!
    
    @IBOutlet weak var codeTimerBtn: BaseButton!
    @IBOutlet weak var codeTimerLabel: UILabel!
    
    class func setupRegisterNormalView() -> RegisterNormalView {
        let registerView = Bundle.main.loadNibNamed("RegisterNormalView", owner: nil, options: nil)?.last as! RegisterNormalView
        
        registerView.frame = UIView.fullScreenBounds()
        registerView.codeTimerLabel.text = "时间:30秒"
        registerView.creatRxSwift()
        return registerView
    
    }

    @IBAction func clickCodeButton(_ sender: BaseButton) {
        codeTimerLabel.isHidden = false
        codeTimerBtn.isHidden = true
        self.countDownStopped.value = false
        timer.takeUntil(countDownStopped.asObservable().filter{$0})
            .subscribe(onNext: { [weak self](event) in
                self!.leftTime.value -= 1
                self?.codeTimerLabel.text = "时间:\(self?.leftTime.value ?? 0)秒"
                if (self!.leftTime.value == 0) {
                    self!.countDownStopped.value = true
                    self!.leftTime.value = 30
                    self!.codeTimerLabel.isHidden = true
                    self!.codeTimerBtn.isHidden = false
                    self?.codeTimerLabel.text = "时间:\(self?.leftTime.value ?? 0)秒"
                }
                }, onError: { (error) in
                    
            }).disposed(by: disposed)
    }
}

extension RegisterNormalView {
    private func creatRxSwift() {
        
        let phoneIsVaild = userTextField.rx.text.orEmpty.map { (tf) -> Bool in
            tf.count == 11
        }
        
        let pwdIsVaild = pwdTextField.rx.text.orEmpty.map {
            $0.count > 11 && $0.count < 22
        }
        
        let surePwdIsVaild = surePwdTextField.rx.text.orEmpty.map { [weak self](tf) -> Bool in
            tf.count > 11 && tf.count < 22 && self!.surePwdTextField.text == self!.pwdTextField.text
        }
        
        let codeIsVaild = codeTextField.rx.text.orEmpty.map {
            $0.count == 6
        }
        
    Observable.combineLatest(phoneIsVaild,pwdIsVaild,surePwdIsVaild,codeIsVaild) {
        $0 && $1 && $2 && $3
        }.subscribe(onNext: { (bool) in
        self.sureButton.isEnabled = bool
        self.sureButton.backgroundColor = bool == true ? UIColor.red : UIColor.gray
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
        
    }
}
