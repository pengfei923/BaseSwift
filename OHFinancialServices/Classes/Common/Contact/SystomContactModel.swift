//
//  SystomContactModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/21.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class SystomContactModel: NSObject {
    @objc var moblie : String = ""
    @objc var name : String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
