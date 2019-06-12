//
//  UITextField-Extension.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/15.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(placeHolder:String,frame:CGRect) {
        self.init(frame: frame)
        self.placeholder = placeHolder;
        self.backgroundColor = UIColor.white
        self.borderStyle = UITextField.BorderStyle.none
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        self.clearButtonMode = .whileEditing
    }
}
