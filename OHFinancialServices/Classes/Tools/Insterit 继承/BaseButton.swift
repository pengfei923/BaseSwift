//
//  BaseButton.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/30.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
        self.setTitle("确  定", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.layer.cornerRadius = KBtnCornerRadius
        self.layer.masksToBounds = true
    }
}
