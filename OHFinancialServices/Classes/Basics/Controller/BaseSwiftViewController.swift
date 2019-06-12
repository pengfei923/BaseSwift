//
//  BaseSwiftViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class BaseSwiftViewController: UIViewController {
    
    var contentView : UIView?
    
    var isShowNavigationBar : Bool?
    
    private lazy var animImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "待签约"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "待签约")!,UIImage(named: "待签约")!];
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicFunc()
        self.view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if isShowNavigationBar == true {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.tintColor = UIColor.clear
            self.view.layer.contents = UIImage(named: "")?.cgImage
        }
        
        if self.navigationController != nil {
            let navBarHairlineImageView = self.findHairlineImageViewUnder(view: self.navigationController!.navigationBar)
            navBarHairlineImageView!.isHidden = true
        }

        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 去掉导航栏下方的黑线
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if isShowNavigationBar == true {
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.tintColor = UIColor.black
        }
        
        if self.navigationController != nil {
            let navBarHairlineImageView = self.findHairlineImageViewUnder(view: self.navigationController!.navigationBar)
            navBarHairlineImageView!.isHidden = false
        }
    }
    
}


extension BaseSwiftViewController {
    @objc func setupUI() {
        
        setNavigationBackItem()
        
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        self.view.backgroundColor = UIColor(r: 230, g: 230, b: 230)
    }
    
    func setNavigationBackItem() {
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "button_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "button_back")
        
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
    
    // 去掉状态栏底部的黑线
    func findHairlineImageViewUnder(view : UIView)->UIImageView!{
        
        if(view.bounds.size.height <= 1.0 ){
            
            return (view as! UIImageView)
        }
        for subview in view.subviews {
            
            let imageView = self .findHairlineImageViewUnder(view: subview)
            
            if (imageView != nil) {
                return imageView
            }
        }
        return nil
    }
}

extension BaseSwiftViewController {
    private func publicFunc() {
        
    }
    
    func hidesKeyBoard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
