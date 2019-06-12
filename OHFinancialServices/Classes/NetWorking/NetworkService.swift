//
//  NetworkService.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/17.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class NetworkService {
    func getRandomResult() -> Driver<[String]> {
        print("正在请求数据....")
        let items = (0 ... 15).map { _ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable.delay(1, scheduler: MainScheduler.instance).asDriver(onErrorDriveWith: Driver.empty())
        
    }

}
