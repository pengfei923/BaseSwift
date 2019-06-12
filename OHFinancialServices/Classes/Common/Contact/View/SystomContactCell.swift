//
//  SystomContactCell.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/21.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class SystomContactCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        leftLabel.text = ""
        rightLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
