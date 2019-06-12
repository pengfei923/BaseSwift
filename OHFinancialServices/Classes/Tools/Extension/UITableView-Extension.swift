//
//  UITableView-Extension.swift
//  DouYuSwift
//
//  Created by hoomsun on 2019/3/26.
//  Copyright © 2019年 hoomsun. All rights reserved.
//

import UIKit


extension UITableView {
    class func creatTableView() -> UITableView {
        let tableView = UITableView(frame: UIView.fullScreenBounds(), style: .grouped)
        tableView.separatorColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
        return tableView
    }
    
    convenience init(frameSelf:CGRect,style:UITableView.Style) {
        self.init(frame: frameSelf, style: style)
        self.separatorColor = UIColor.clear
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if #available(iOS 11.0, *) {
            estimatedSectionHeaderHeight = 0
            estimatedRowHeight = 0;
            estimatedSectionFooterHeight = 0;
            contentInsetAdjustmentBehavior = .never
        }
    }
}
