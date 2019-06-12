//
//  Float-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/9.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

var origin : CGPoint?


extension UIView {
    var origin : CGPoint {
        set {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
}
