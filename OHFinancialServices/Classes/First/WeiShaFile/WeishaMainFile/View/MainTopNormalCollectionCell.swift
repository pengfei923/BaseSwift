//
//  MainTopNormalCollectionCell.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class MainTopNormalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconTitleLabel.text = ""
        // Initialization code
    }

}
