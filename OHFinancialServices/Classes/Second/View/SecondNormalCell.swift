//
//  SecondNormalCell.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class SecondNormalCell: UITableViewCell {

//    var data : SecondModel {
//        didSet {
//
//        }
//    }
    
//    var data : SecondModel? {
//        didSet {
//            self.titleLabel.text = data?.prodName ?? ""
//            self.leftTitleLabel.text = data?.rateDesc ?? ""
////            self.rightTitleLabel.text = data?.amtlimit
//        }
//    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = ""
        self.leftTitleLabel.text = ""
        self.rightTitleLabel.text = ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
