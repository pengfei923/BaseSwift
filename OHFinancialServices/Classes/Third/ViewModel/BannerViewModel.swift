//
//  BannerViewModel.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/29.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class BannerViewModel: NSObject {
    
    lazy var bannerModel : [BannerModel] = [BannerModel]()
    
    func requestBannerModel(finishedCallBack:@escaping(_ result : [BannerModel])->()) {
        NetWorkTools.requestPostData(url: "/banner/banner.do") { [weak self](result) in
            guard let bannerArr = result as? [[String : Any]] else {return}
            for dict in bannerArr {
                let model = BannerModel(dict: dict)
                self!.bannerModel.append(model)
            }
            finishedCallBack(self!.bannerModel)
        }
    }

}
