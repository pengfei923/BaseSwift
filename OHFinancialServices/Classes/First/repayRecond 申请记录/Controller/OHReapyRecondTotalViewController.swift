//
//  OHReapyRecondTotalViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/6/12.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

private let KTitleViewH : CGFloat = 44

class OHReapyRecondTotalViewController: BaseSwiftViewController {
    
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KTitleViewH)
        let titles = ["登录","注册","学习"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contentH = kScreenH - (kStatusBarH + kNavigationBarH + KTitleViewH) - kTabBarH
        let  contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(OHRepayFirstViewController())
        childVcs.append(OHRepaySecondViewController())
        childVcs.append(OHRepayFirstViewController())
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "申请记录"
        
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        loadDataFinished()
    }

}


extension OHReapyRecondTotalViewController :PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension OHReapyRecondTotalViewController :PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
