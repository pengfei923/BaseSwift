//
//  Other-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/13.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class Other_Extension: NSObject {

}


extension CGRect {
    init(center:CGPoint,size:CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}
///返回个数的下标 从最后一位算起0
extension Int {
    subscript(digitIndex:Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
}
