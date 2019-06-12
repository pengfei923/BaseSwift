//
//  String-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/8.
//  Copyright © 2019 李鹏飞. All rights reserved.
//

import UIKit

extension String {
    static func getUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    static func getDeviceType() -> String {
        return UIDevice.current.model
    }
    
    static func getVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    /// 获取缓存数据信息
    static func getCacheSize() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        var size = 0
        for file in fileArr! {
            let path = cachePath! + "/\(file)"
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            for (key, fileSize) in floder {
                if key == FileAttributeKey.size {
                    size += (fileSize as AnyObject).integerValue
                }
                
            }
        }
        let totalCache = Double(size) / 1024.00 / 1024.00
        return String(format: "%.2f", totalCache)
    }
    /// 删除缓存信息
    static func clearCache() {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        for file in fileArr! {
            let path = cachePath! + "/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                }catch {
                    
                }
            }
        }
    }
    /// 字典转字符串
    static func dictValueString(_ dict:[String:Any]) -> String {
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let str = String(data: data!, encoding: .utf8)
        return str!
    }
    /// 日期转字符串
    static func dateToString(_ date:Date,dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    /// 金额千分符的实现
    func addMicrometerLevel() -> String {
        if self.count != 0 {
            var integerPart : String?
            var decimalPart = String.init()
            
            integerPart = self
            
            if self.contains(".") {
                let segmentationArray = self.components(separatedBy: ".")
                integerPart = segmentationArray.first
                decimalPart = segmentationArray.last!
            }
            
            let remainderMutableArray = NSMutableArray.init(capacity: 0)
            var discussValue : Int32 = 0
            
            repeat {
                let tempValue = integerPart! as NSString
                discussValue = tempValue.intValue / 1000
                let remainderValue = tempValue.intValue % 1000
                let remainderStr = String.init(format: "%d", remainderValue)
                remainderMutableArray.insert(remainderStr, at: 0)
                integerPart = String.init(format: "%d", discussValue)
            } while discussValue>0
            
            var tempString = String.init()
            let lastKey = (decimalPart.count == 0 ? "":".")
            for i in 0..<remainderMutableArray.count {
                let  param = (i != remainderMutableArray.count-1 ?",":lastKey)
                tempString = tempString + String.init(format: "%@%@", remainderMutableArray[i] as! String,param)
            }
            integerPart = nil
            remainderMutableArray.removeAllObjects()
            if decimalPart.isEmpty {
                decimalPart = ".00"
            }
            if decimalPart.count == 1 {
                decimalPart = decimalPart + "0"
            }
            return tempString as String + decimalPart + "元"
        }
        return self
    }
}
