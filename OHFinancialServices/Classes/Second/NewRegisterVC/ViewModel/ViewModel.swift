//
//  ViewModel.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/17.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ViewModel {
    
    lazy var livems : [LiveNormalModel] = [LiveNormalModel]()
    
    let tableData : Driver<[String]>
    
    let endHeaderRefreshing : Driver<Bool>
    
    init(headerRefresh:Driver<Void>) {
        let networkService = NetworkService()
        self.tableData = headerRefresh.startWith(()).flatMapLatest{
            _ in
            networkService.getRandomResult()
        }

        self.endHeaderRefreshing = self.tableData.map{
            _ in
            true
        }
    }
    
}

