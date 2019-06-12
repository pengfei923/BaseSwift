//
//  UserModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    @objc var id : String = ""
    @objc var photopath : String = ""
    @objc var uploadIp : String = ""
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}

//struct userModel : Codable {
//    var id : String = ""
//    var photopath : String = ""
//    var uploadIp : String = ""
//    
//
//}
