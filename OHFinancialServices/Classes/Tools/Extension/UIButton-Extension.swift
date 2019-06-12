//
//  UIButton-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 李鹏飞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let disposed = DisposeBag()
let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)

let countDownStopped = Variable(true)
let leftTime = Variable(Int(30))

extension UIButton {
    convenience init(title:String,frame:CGRect,corner:CGFloat = 0) {
        self.init(type: .system)
        self.frame = frame
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.lightGray, for: .highlighted)
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
        backgroundColor = UIColor.red
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
}
