//
//  PersonNormalTableCell.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class PersonNormalTableCell: UITableViewCell {

    @IBOutlet weak var personListIcon: UIImageView!
    
    @IBOutlet weak var personListText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personListText.text = ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
