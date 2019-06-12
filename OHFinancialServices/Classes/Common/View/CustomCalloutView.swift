//
//  CustomCalloutView.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/13.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {

    var image : UIImage? = nil //商户图
    var title : String? = "" //商户名
    var subTitle : String? = "" //地址
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawInContext(context: UIGraphicsGetCurrentContext()!)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    
    }

    func drawInContext(context:CGContext) {
        context.setLineWidth(2.0)
        context.setFillColor(UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1).cgColor)
        getDrawPath(context: context)
    }
    
    func getDrawPath(context:CGContext) {
        
    }
    
}
