//
//  MapViewController.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/10.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class MapViewController: BaseSwiftViewController {

    private lazy var mapTools : MapTools = {
        let mapTools = MapTools()
        mapTools.currentViewController = self
        return mapTools
    }()
    
    
    
    private lazy var newMap : NewMapView = NewMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapTools.showCenterMapViewAndName()
        
    }
    
    override func setupUI() {
        super.setupUI()
        title = "高德地图"
        loadDataFinished()
//        isShowNavigationBar = true
    }
    

}
