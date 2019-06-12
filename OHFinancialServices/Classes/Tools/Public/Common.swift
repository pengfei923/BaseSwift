//
//  Common.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit


//let kStatusBarH : CGFloat = 20
let kStatusBarH : CGFloat = Bool.isIPhoneXSeries() ? 44 : 20


let kNavigationBarH : CGFloat = 44
let kTabBarH : CGFloat = 44
let kScreenW = UIScreen.main.bounds.width

let kScreenH = UIScreen.main.bounds.height

/// iphoneX 上部的安全距离
let KSafeScreenTopMargin : CGFloat = 44

/// iphoneX 下部的安全距离
let KSafeScreenBottomMargin : CGFloat = Bool.isIPhoneXSeries() ? 43 : 0


let KBtnCornerRadius : CGFloat = 5

let KTopDistance : CGFloat = Bool.isIPhoneXSeries() ? 44 : 0

/// 高德地图的key
let KMapKey : String = "d144cc5454090cca1ec49806b21b6699"

