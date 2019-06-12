//
//  AuthorizationTool.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/9.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos
import AddressBook
import AddressBookUI
import CoreLocation
import Contacts
enum AuthorizationStatus:Int {
    case Authorized = 0
    case Denied = 1 // 拒绝
    case Restricted = 2 //应用没有相关权限，且用户无法改变，家长控制
    case NotSupport = 3 // 硬件不支持
}

enum LocationAuthorizationStatus : Int {
    case NotDetermined = 0
    case AuthorizedAlways = 1 //一直定位
    case AuthorizedWhenInUse = 2 // 使用时定位
    case Denied = 3 // 拒绝
    case Restricted = 4 //应用没有相关权限，且用户无法改变，家长控制
    case NotSupport = 5 // 硬件不支持
}

class AuthorizationTool: NSObject {
    /// 请求访问相册权限
    func requestImagePickerAuthorization(finishedCallBack:@escaping (_ status:AuthorizationStatus)->()) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) || UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            if (PHAuthorizationStatus(rawValue: 0) != nil) {
                PHPhotoLibrary.requestAuthorization { [weak self](status) in
                    if status == .authorized {
                        self?.execute(status: .Authorized, callBack: finishedCallBack)
                    }else if status == .denied {
                        self?.execute(status: .Denied, callBack: finishedCallBack)
                    }else if status == .restricted {
                        self?.execute(status: .Restricted, callBack: finishedCallBack)
                    }
                }
            }else if (PHAuthorizationStatus(rawValue: 1) != nil) {
                execute(status: .Restricted, callBack: finishedCallBack)
            }else if (PHAuthorizationStatus(rawValue: 2) != nil) {
                execute(status: .Denied, callBack: finishedCallBack)
            }else if (PHAuthorizationStatus(rawValue: 3) != nil) {
                execute(status: .Authorized, callBack: finishedCallBack)
            }
            
        }else {
            execute(status: .NotSupport, callBack: finishedCallBack)
        }
    }
    
    /// 请求访问相机权限
    func requestCameraAuthorizetion(finishedCallBack:@escaping (_ status: AuthorizationStatus)->()) {
        let CameraauthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if CameraauthStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { [weak self](bool) in
                    if bool == true {
                        self?.execute(status: .Authorized, callBack: finishedCallBack)
                    }else {
                        self?.execute(status: .Denied, callBack: finishedCallBack)
                    }
                }
            }else if CameraauthStatus == .authorized {
                execute(status: .Authorized, callBack: finishedCallBack)
            }else if CameraauthStatus == .denied {
                execute(status: .Denied, callBack: finishedCallBack)
            }else if CameraauthStatus == .restricted {
                execute(status: .Restricted, callBack: finishedCallBack)
            }
        }else {
            execute(status: .NotSupport, callBack: finishedCallBack)
        }
    }
    
    /// 通讯录权限
    func requestAddressBackAuthorization(finishedCallBack:@escaping (_ status: AuthorizationStatus)->()) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { [weak self](bool, error) in
            if bool == true {
                self?.execute(status: .Authorized, callBack: finishedCallBack)
            }else {
                self?.execute(status: .NotSupport, callBack: finishedCallBack)
            }
        }
        
        
    }
    
    /// 定位权限
    func requestLocationAuthorization(finishedCallBack:@escaping (_ status: LocationAuthorizationStatus)->()) {
        let enableLocation: Bool = CLLocationManager.locationServicesEnabled()
        let locaStatus = CLLocationManager.authorizationStatus() as CLAuthorizationStatus
        if  enableLocation == true {
            if locaStatus == .notDetermined {
                executeLocation(status: .NotDetermined, callBack: finishedCallBack)
            }else if locaStatus == .authorizedAlways {
                executeLocation(status: .AuthorizedAlways, callBack: finishedCallBack)
            }else if locaStatus == .authorizedWhenInUse {
                executeLocation(status: .AuthorizedWhenInUse, callBack: finishedCallBack)
            }else if locaStatus == .denied {
                executeLocation(status: .Denied, callBack: finishedCallBack)
            }else if locaStatus == .restricted {
                executeLocation(status: .Restricted, callBack: finishedCallBack)
            }
            
        }else {
            executeLocation(status: .NotSupport, callBack: finishedCallBack)
        }
        
    }
    
    private func execute(status : AuthorizationStatus,callBack:@escaping (_ callBack:AuthorizationStatus)->()) {
        DispatchQueue.main.async {
            callBack(status)
        }
    }
    
    private func executeLocation(status:LocationAuthorizationStatus,callBack:@escaping (_ status:LocationAuthorizationStatus)->()) {
        DispatchQueue.main.async {
            callBack(status)
        }
    }
    
}

