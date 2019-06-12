//
//  UIView-Extension.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/3/26.
//  Copyright © 2019年 hoomsun. All rights reserved.
//

import UIKit

extension UIView {
    class func fullScreenBounds() -> CGRect {
        
        return CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - KSafeScreenBottomMargin)
    }
}
