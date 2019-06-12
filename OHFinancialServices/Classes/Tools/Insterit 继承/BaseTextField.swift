//
//  BaseTextField.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = UIColor.lightGray
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.clearButtonMode = .whileEditing
    }
}
