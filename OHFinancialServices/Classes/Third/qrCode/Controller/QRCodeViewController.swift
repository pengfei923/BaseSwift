//
//  QRCodeViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/10.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class QRCodeViewController: BaseSwiftViewController {

    private lazy var qrCodeImageView : UIImageView = {
        let qrCodeImageView = UIImageView(frame: CGRect(x: 40, y: 100, width: 200, height: 200))
        qrCodeImageView.center = CGPoint(x: kScreenW/2, y: kScreenH/2)
        return qrCodeImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(qrCodeImageView)
        let image = #imageLiteral(resourceName: "center_header")
        let qrimage : UIImage = UIImage.creatQRCodeImage(url: "http://www.baidu.com", image: image)
        
        qrCodeImageView.image = qrimage
        // Do any additional setup after loading the view.
    }
    

}
