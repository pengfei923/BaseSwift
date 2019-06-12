//
//  SecondViewModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class SecondViewModel : NSObject {
    
    lazy var secondModel : [SecondModel] = [SecondModel]()
        
    func reloadData(finishedCallBack:@escaping(_ result : [SecondModel])->()) {
        let dict = ["idNumber":"61052319910609847X","province":"陕西省","city":"西安市","area":"碑林区"]
        NetWorkTools.requestPostData(url: "/product/creditproduct.do", parameters: dict) { [weak self](result) in
            self!.secondModel.removeAll()
            guard let dataArray = result as? [[String : Any]] else {return}
            for dict in dataArray {
                let model = SecondModel(dict: dict)
                self!.secondModel.append(model)
            }
            finishedCallBack(self!.secondModel)
            
        }
    }
}
