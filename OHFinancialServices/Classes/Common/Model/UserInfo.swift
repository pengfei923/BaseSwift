//
//  UserInfo.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit



class UserInfo: NSObject,NSCoding {
        
    var custname : String? = ""
    var sex : String? = ""
    var bankpwd :String? = "" //银行卡密码
    var id : String? = "" // 用户id
    var paperid : String? = "" // 用户身份信息
    var phone : String? = "" // 用户手机号码
    var phoneModel : String? = "" //
    var photopath : String? = "" // 用户头像
    var pwd : String? = "" // 用户密码
        
    override init() {
        super.init()
    }

    // 从NSObject解析回来
    required init(coder aDecoder:NSCoder) {
        self.custname = aDecoder.decodeObject(forKey: "custname") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
        self.sex = aDecoder.decodeObject(forKey: "sex") as? String
        self.bankpwd = aDecoder.decodeObject(forKey: "bankpwd") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.paperid = aDecoder.decodeObject(forKey: "paperid") as? String
        self.phoneModel = aDecoder.decodeObject(forKey: "phoneModel") as? String
        self.pwd = aDecoder.decodeObject(forKey: "pwd") as? String
        self.photopath = aDecoder.decodeObject(forKey: "photopath") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(custname, forKey: "custname")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(bankpwd, forKey: "bankpwd")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(paperid, forKey: "paperid")
        aCoder.encode(phoneModel, forKey: "phoneModel")
        aCoder.encode(pwd, forKey: "pwd")
        aCoder.encode(photopath, forKey: "photopath")
    }
    
}
