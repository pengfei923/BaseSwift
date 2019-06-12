//
//  BaseLabel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/5.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class noticeLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont.systemFont(ofSize: 13)
        self.textColor = UIColor.red
        
    }
}
