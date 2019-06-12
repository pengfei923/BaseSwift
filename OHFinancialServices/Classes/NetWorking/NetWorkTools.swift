//
//  NetWorkTools.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import Alamofire

let KApiUrl = "http://weisha.fanjiedata.com:9093/web"


class NetWorkTools: NSObject {
    
    /// 使用get请求数据
    class func requestGetData(url:String,parameters:[String:String]? = nil,finishedCallBack:@escaping (_ result:Any)->()) {
        Alamofire.request(KApiUrl + url, method: .get, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            print("这里是返回的原始数据信息\(result)")
            guard let resultDict = result as? [String : Any] else {return}
            guard let errorCode = resultDict["errorCode"] as? Float else {return}
            guard let errorInfo = resultDict["errorInfo"] as? String else {return}
            
            if errorCode == 0 {
                finishedCallBack(resultDict["data"] as Any)
            } else {
                SwiftNotice.showNoticeWithText(.error, text: "\(errorInfo)", autoClear: true, autoClearTime: 1)
            }
            
            
        }
        
    }
    //获取post请求数据
    class func requestPostData(url:String,parameters:[String:String]? = nil,finishedCallBack:@escaping (_ result:Any)->()) {
        Alamofire.request(KApiUrl + url, method: .post, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            print("这里是返回的原始数据信息\(result)")
            guard let resultDict = result as? [String : Any] else {return}
            guard let errorCode = resultDict["errorCode"] as? Float else {return}
            guard let errorInfo = resultDict["errorInfo"] as? String else {return}
            
            if errorCode == 0 {
                finishedCallBack(resultDict["data"] as Any)
            } else {
                SwiftNotice.showNoticeWithText(.error, text: "\(errorInfo)", autoClear: true, autoClearTime: 1)
            }
        }
    }
    
    /// 上传图片功能实现
    class func uploadImageToService(url:String,parameters:[String:String]? = nil,imageStr:String,finishedCallBack:@escaping (_ result: Any) -> ()) {
        
        let imageData = UIImage(named: imageStr)?.jpegData(compressionQuality: 0.5)
                
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "file", fileName: "img.jpg", mimeType: "image/jpeg")
            for(key,value) in parameters! {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: url) { encodingResul in
            switch encodingResul {
            case .success(let upload, _, _) :
                upload.responseJSON(completionHandler: { (response) in
                    guard let result = response.result.value else {return}
                    guard let resultDict = result as? [String : Any] else {return}
                    guard let dataDict = resultDict["data"] as? [String : Any] else {return}
                    guard let errorCode = resultDict["errorCode"] as? Float else {return}
                    guard let errorInfo = resultDict["errorInfo"] as? String else {return}
                    
                    if errorCode == 0 {
                        finishedCallBack(dataDict)
                    } else {
                        SwiftNotice.showNoticeWithText(.error, text: "\(errorInfo)", autoClear: true, autoClearTime: 1)
                    }
                })
            case .failure(let error) :
                print(error)
            }
        }
        
    }
}
