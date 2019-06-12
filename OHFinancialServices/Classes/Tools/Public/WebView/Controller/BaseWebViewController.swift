//
//  BaseWebViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/5.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import WebKit
class BaseWebViewController: BaseSwiftViewController {

    public var titleStr : String? {
        didSet {
            self.title = titleStr
        }
    }
    
    public var urlString : String? {
        didSet {
            publicWebView.load(URLRequest(url: URL(string: self.urlString!)!))
        }
    }
    
    public var progressView : UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.frame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: 1)
        progressView.tintColor = UIColor.clear
        progressView.progressTintColor = UIColor.red
        return progressView
    }()
    
    private var publicWebView : WKWebView = {
        let publicWebView = WKWebView(frame: UIView.fullScreenBounds())
        
        return publicWebView
    }()
    
    
//    init(titleStr:String,urlString:String) {
//        super.init()
//        self.titleStr = titleStr
//        self.urlString = urlString
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func setupUI() {
        super.setupUI()
        creatWebView()
        loadDataFinished()
    }

    deinit {
        publicWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

extension BaseWebViewController {
    private func creatWebView() {
        view.addSubview(publicWebView)
        view.addSubview(progressView)
        publicWebView .addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = publicWebView.estimatedProgress == 1
            progressView.setProgress((Float(publicWebView.estimatedProgress)), animated: true)
            print("\(publicWebView.estimatedProgress)")
        }
    }
}

