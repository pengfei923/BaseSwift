//
//  PublicAlertController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/13.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class PublicAlertController: NSObject {
    /// 正常弹框展示信息(有确认和取消)
    class func showAlertController(title:String?,message:String?,preferredStyle:UIAlertController.Style,sureAction:String?,cancleAction:String?,handler:((UIAlertAction)->Void)?,finishedBack:((UIAlertController)->())?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let doAction = UIAlertAction(title: sureAction, style: .default, handler: handler)
        
        let cancleAction = UIAlertAction(title: cancleAction, style: .cancel, handler: nil)
        
        alertController.addAction(doAction)
        alertController.addAction(cancleAction)
        
        finishedBack!(alertController)
    }
    /// 只有一个确认按钮的框
    class func showOneSureButtonAlertControlle(title:String?,message:String?,sureAction:String?,handler:((UIAlertAction)->Void)?,finishedBack:((UIAlertController)->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doAction = UIAlertAction(title: sureAction, style: .default, handler: handler)
        alertController.addAction(doAction)
        finishedBack!(alertController)
    }
}
