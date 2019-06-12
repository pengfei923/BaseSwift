//
//  MainTabbarViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/4/28.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        addChildVC(storyName: "First")
        addChildVC(storyName: "Second")
        addChildVC(storyName: "Third")
        
    }
    
    
    private func addChildVC(storyName:String) {
        let childvc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        self.tabBar.tintColor = UIColor.orange
        addChild(childvc)
    }
    

}
