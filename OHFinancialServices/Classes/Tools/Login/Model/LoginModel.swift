//
//  LoginModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class LoginModel: NSObject {
    @objc var bankpwd :String? = "" //银行卡密码
    @objc var id : String? = "" // 用户id
    @objc var paperid : String? = "" // 用户身份信息
    @objc var phone : String? = "" // 用户手机号码
    @objc var phoneModel : String? = "" //
    @objc var photopath : String? = "" // 用户头像
    @objc var pwd : String? = "" // 用户密码
    @objc var custname : String? = "" // 用户名称
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
