//
//  NSDate-Extension.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/3/26.
//  Copyright © 2019年 hoomsun. All rights reserved.
//

import UIKit

enum FormatterType : String {
    case yyyymmddhhmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyymmdd = "yyyy-MM-dd"
    case yyyymmddhhmm = "yyyy-MM-dd HH:mm"
}

extension NSDate {
    //返回当前时间戳
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
    // 返回当前的时间
    class func getCurrentCommonTime(type:FormatterType) -> String {
        let newDate = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = type.rawValue
        let str = formatter.string(from: newDate as Date)
        return str
    }
    
    
    
}

extension Date {
    static func stringToDate(_ string:String,dateFormat:String = "yyyy-MM-dd hh:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
}
