//
//  LoginInfo.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class LoginInfo: NSObject {
    private let kLoginInfoFileName : String = "info" //登录保存信息
    private let KUserInfoFileName : String = "UserInfo" //个人用户信息
    
    // 登录后，保存用户信息
    func saveUserInfo(userInfo:UserInfo) {
        let path = pathForName(name: KUserInfoFileName)
        NSKeyedArchiver.archiveRootObject(userInfo, toFile: path)
    }
    
    // 获取保存用户信息
    func savedUserInfo() -> UserInfo? {
        let path = pathForName(name: KUserInfoFileName)
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? UserInfo
        return obj
    }
    
    // 删除用户保存信息
    func removeSavedUserInfo() {
        let path = pathForName(name: KUserInfoFileName)
        let exist = FileManager.default.fileExists(atPath: path)
        if exist {
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    // 获取路径信息
    func pathForName(name:String) -> String {
        let libraryPath : String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return libraryPath + "/" + name
    }
    
}
