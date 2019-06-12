//
//  UIBarBUttonItem-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 李鹏飞. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String,highImageImage:String = "",size:CGSize = .zero,target: Any?,action:Selector) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageImage != "" {
            btn.setImage(UIImage(named: highImageImage), for: .highlighted)
        }
        
        if size == .zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView:btn)
    }
    
    convenience init(title:String,target:Any?,action:Selector?) {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.setTitleColor(UIColor.Black_51(), for: .normal)
        btn.setTitleColor(UIColor.Gray_102(), for: .highlighted)
        btn.addTarget(target, action: action!, for: .touchUpInside)
        self.init(customView:btn)
    }
}
