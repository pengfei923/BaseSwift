//
//  MapTools.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/10.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

class MapTools: NSObject {
    
    var currentViewController : UIViewController?
    
    var centerPoint : CGPoint?
    
    var addressName : String?
    
    private lazy var centerAnnotation : MAPointAnnotation =  {
        let centerAnnotation = MAPointAnnotation()
        return centerAnnotation
    }()
    
    private lazy var request : AMapPOIKeywordsSearchRequest = {
        let request = AMapPOIKeywordsSearchRequest()
        request.requireExtension = true
        return request
    }()
    
    private lazy var locationManager : AMapLocationManager = {
        let locationManager = AMapLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.locationTimeout = 3
        locationManager.reGeocodeTimeout = 3
        locationManager.distanceFilter = 2
        return locationManager
    }()
    
    private lazy var search : AMapSearchAPI = {
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    
    private lazy var annotationView : NewCustomAnnotationView = {
        let annotationView = NewCustomAnnotationView()
        return annotationView
    }()
    
    //懒加载一个mapView
    private lazy var mapView : MAMapView = {
        defer {
            SwiftNotice.noticeOnStatusBar("正在定位中...", autoClear: true, autoClearTime: 3)
        }
        let mapView = MAMapView(frame: CGRect(x: 0, y: KTopDistance, width: kScreenW, height: kScreenH - KTopDistance - KSafeScreenBottomMargin))
        mapView.zoomLevel = 17
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        return mapView
    }()
    
    /// 初始化地图定位蓝点
    private lazy var r : MAUserLocationRepresentation = {
        let r = MAUserLocationRepresentation()
        r.strokeColor = UIColor.clear
        r.lineWidth = 1
        r.locationDotFillColor = UIColor.clear
        r.enablePulseAnnimation = true
        r.strokeColor = UIColor.clear
        return r
    }()

    private lazy var regeo : AMapReGeocodeSearchRequest = {
        let regeo = AMapReGeocodeSearchRequest()
        regeo.requireExtension = true
        return regeo
    }()
    
    /// MARK: -获取地图中心点并展示名称
    func showCenterMapViewAndName() {
        currentViewController!.view.addSubview(mapView)
        requestManagerLocation()
    }
    
    func showMapView() {
        currentViewController!.view.addSubview(mapView)
    }
    
}
//MARK: -获取map中心点位置并且展示内容
extension MapTools {
    func requestManagerLocation() {
        locationManager.requestLocation(withReGeocode: true) { [weak self](location, reGeocode, error) in
            guard let lat = location?.coordinate.latitude else {return}
            guard let lon = location?.coordinate.longitude else {return}
            guard let addressName = reGeocode?.poiName else {return}
            self?.addressName = addressName
            let locationCoor = CLLocationCoordinate2DMake(lat, lon)
            self?.mapView.zoomLevel = 17
            self?.mapView.rotationDegree = 0
            self?.mapView.removeAnnotation(self?.centerAnnotation)
            self?.centerAnnotation.coordinate = locationCoor
            self?.mapView.addAnnotation(self?.centerAnnotation)
            let convertedMapCenterCoor = self!.mapView.convert(CGPoint(x: kScreenW/2, y: kScreenH/2), toCoordinateFrom: self?.mapView)
            
            self?.mapView.setCenter(convertedMapCenterCoor, animated: true)
            self?.annotationView.setSelected(true, animated: true)
            ///这里添加 addAnnotation
            
        }
    }
    
    func searchReGeocodeWithCoordinate(coordinate:CLLocationCoordinate2D) {
        regeo.location = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        regeo.requireExtension = true
        search.aMapReGoecodeSearch(regeo)
    }
}

extension MapTools:AMapSearchDelegate {
    // 获取到定位之后的返回信息
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode.pois.count < 1 {
            return
        }
        guard let addressName = response.regeocode.pois[0].name else {
            return
        }
        
        annotationView.title = addressName
        annotationView.setSelected(true, animated: true)
    }
}

extension MapTools:MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAUserLocation.self) {
            return nil
        }
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIdetifier = "pointReuseIndetifier"
            var annotationView  = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIdetifier) as? NewCustomAnnotationView
            if annotationView == nil {
                annotationView = NewCustomAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIdetifier)
            }
            self.annotationView = annotationView!
            annotationView?.isSelected = true
            annotationView?.image = UIImage(named: "person_balance")
            annotationView?.centerOffset = CGPoint(x: 0, y: -18)
            annotationView?.setSelected(true, animated: true)
            annotationView?.title = addressName ?? ""
            return annotationView!
        }
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        searchReGeocodeWithCoordinate(coordinate: self.centerAnnotation.coordinate)
    }
    
    func mapView(_ mapView: MAMapView!, mapWillMoveByUser wasUserAction: Bool) {
        annotationView.setSelected(false, animated: true)
    }
    
    func mapViewRegionChanged(_ mapView: MAMapView!) {
        let convertedLocationAnnoCoor = mapView.convert(CGPoint(x: kScreenW/2, y: kScreenH/2), toCoordinateFrom: mapView)
        
        centerAnnotation.coordinate = convertedLocationAnnoCoor
    }
    
}
