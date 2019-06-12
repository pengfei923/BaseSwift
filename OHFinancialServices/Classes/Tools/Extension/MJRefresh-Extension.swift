//
//  MJRefresh-Extension.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/4/17.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base:MJRefreshComponent {
    //正在刷新事件
    var refreshing : ControlEvent<Void> {
        let source : Observable<Void> = Observable.create {
            [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
        
    }
    
    //停止刷新事件
    var endRefreshing : Binder<Bool> {
        return Binder(base) {
            refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}
