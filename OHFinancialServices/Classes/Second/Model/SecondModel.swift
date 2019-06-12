//
//  SecondModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class SecondModel : NSObject {
    
    @objc var amtlimit : Int = 0
    @objc var deleteSign : Int = 0
    @objc var effflagVal : Int = 0
    @objc var gotourl : String = ""
    @objc var isonline : Int = 0
    @objc var isopen : Int = 0
    @objc var isopenVal : String = ""
    @objc var maxCreditAmt : Int = 0
    @objc var maxRate : String = ""
    @objc var minRate : String = ""
    @objc var mixCreditAmt : Int = 0
    @objc var prodAlias : String = ""
    @objc var prodCode : String = ""
    @objc var prodId : String = ""
    @objc var prodName : String = ""
    @objc var productdesc : String = ""
    @objc var producturl : String = ""
    @objc var rateDesc : String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
