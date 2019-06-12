//
//  FirstViewModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class FirstViewModel {
    func reloadData(finishedCallBack:@escaping(_ result : UserModel)->()) {
        let uid = ["ID":"89ba48e594f84d2db4071efa895afbf2"]
        NetWorkTools.uploadImageToService(url: "http://weisha.fanjiedata.com:9093/web/upload/uploadimg.do", parameters: uid, imageStr: "待签约") { (result) in
            
            let user = UserModel(dict: result as! [String : Any])
            finishedCallBack(user)
        }
    }
}
