//
//  UIColor-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 李鹏飞. All rights reserved.
//

import UIKit

extension UIColor {
    // 便利构造函数
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func Black_51() -> UIColor {
        return UIColor(r: 51, g: 51, b: 51)
    }
    class func Gray_102() -> UIColor {
        return UIColor(r: 102, g: 102, b: 102)
    }
}
