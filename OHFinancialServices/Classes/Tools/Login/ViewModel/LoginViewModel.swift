//
//  LoginViewModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    func reloadData(phone:String,pwd:String,finishedCallBack:@escaping(_ result: LoginModel)->()) {
        let paramsArr = ["PHONE":phone,"REGISTRATIONID":"123123","PWD":pwd,"WXTAKEN":"23423","UUID":String.getUUID(),"CLIENT":"234234"]
        NetWorkTools.requestPostData(url: "/registerandlogin/login.do", parameters: paramsArr) { (result) in
            guard let dataDict = result as? [String : Any] else {return}
            let loginModel = LoginModel(dict: dataDict)
            finishedCallBack(loginModel)
        }
    }
}
