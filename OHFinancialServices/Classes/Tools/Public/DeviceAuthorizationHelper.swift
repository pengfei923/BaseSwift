//
//  DeviceAuthorizationHelper.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/9.
//  Copyright © 2019 李鹏飞. All rights reserved.
//

import UIKit

enum PhotoSelectionOption {
    case all
    case photoLibrary
    case shot
}

protocol ImageChooseControlDelegate {
    func imageDidChooseFinished(image:UIImage)
    func imageDidChooseCancle()
}

class DeviceAuthorizationHelper: NSObject {
    var delegate : ImageChooseControlDelegate?
    
    typealias photoSelectCompletion = (_ image:UIImage,_ isCancle:Bool) -> ()
    var photoCompletion : photoSelectCompletion?
    
    var pickerTitle : String? = "选择"
    
    var superViewController : UIViewController?
    
    var allowsEditing : Bool? = true
    
    var image : UIImage?
    
    private lazy var imagePicker : UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    private var tool : AuthorizationTool = AuthorizationTool()
    
    var authorized : Bool?
    /// 打开相机权限
    private func cameraIsNotAuthorizedAndShowAlert(completion:@escaping (_ needAlert:Bool)->()) {
        tool.requestCameraAuthorizetion { [weak self](status) in
            self?.authorized = self!.getAuthorizationBoolStatus(status: status)
            if self?.authorized == false {
                self?.showAlertController(title: "提示", message: "请打开相机访问权限", style: .alert, actionBack: { (bool) in
                    
                })
            }
            if self?.authorized == true {
                completion(true)
            }
        }
    }
    /// 打开相册权限
    private func photoLibraryIsNotAuthorizedAndShowAlert(completion:@escaping (_ needAlert:Bool)->()) {
        tool.requestImagePickerAuthorization { [weak self](status) in
            self?.authorized = self?.getAuthorizationBoolStatus(status: status)
            if self?.authorized == false {
                self?.showAlertController(title: "提示", message: "请打开相册访问权限", style: .alert, actionBack: { (bool) in
                    
                })
            }
            if self?.authorized == true {
                completion(true)
            }
        }
    }
    
    func photoSelection(completion:@escaping (_ image:UIImage,_ isCancle:Bool)->()) {
        photoCompletion = completion
        photoSelection(option: .all)
    }
    
    func photoFromShot(completion:@escaping (_ image:UIImage,_ isCancle:Bool)->()) {
        photoCompletion = completion
        photoSelection(option: .shot)
    }
    /// 获取定位权限
    func locationIsNotAuthorizedAndShowAlert(completion:@escaping (_ needAlert:Bool,_ message:String)->()) {
        tool.requestLocationAuthorization { (status) in
            if status == .NotDetermined || status == .AuthorizedAlways {
                completion(false,"开启定位权限，应用总是定位")
                return
            }
            if status == .NotDetermined || status == .AuthorizedWhenInUse {
                completion(false,"开启定位权限，应用在运行时定位")
                return
            }
            if status == .Denied || status == .Restricted {
                completion(true,"定位权限没有开启")
            }
            if status == .NotSupport {
                completion(true,"设备不支持开启定位权限")
            }
            self .showAlertController(title: "提示", message: "定位权限没有开启，请开启自己的定位权限", style: .alert, actionBack: { (bool) in
                
            })
        }
    }
    
    
    
    private func showAlertController(title:String,message:String,style:UIAlertController.Style,actionBack:@escaping (_ confirm:Bool)->()) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        alertVC.addAction(cancel)
        let confirm = UIAlertAction(title: "设置", style: .default) { (action) in
            actionBack(true)
            guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
            if #available(iOS 10, *) {
                if UIApplication.shared.canOpenURL(url) == true {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (bool) in
                        
                    })
                }
            }else {
                if UIApplication.shared.canOpenURL(url) == true {
                    UIApplication.shared.openURL(url)
                }
            }
            
        }
        alertVC.addAction(confirm)
        let vc = UIViewController.current()
        vc.present(alertVC, animated: true, completion: nil)
        
    }
    // 拨打电话权限
    func call(phone:String,completion:@escaping (_ finished:Bool,_ errorMessage:String)->()) {
        if phone.isEmpty {
            completion(false,"电话号码不存在")
            return
        }
        let photoString = "tel://\(phone)"
        guard let url = URL(string: photoString) else {return}
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.openURL(url)
                completion(true,"可以拨打电话")
            }
        }else {
            completion(false,"该设备无法拨打电话")
        }
        
    }
    
    private func photoSelection(option:PhotoSelectionOption) {
        switch option {
        case .all:
            let alertVC = UIAlertController(title: pickerTitle, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
                
            }
            alertVC.addAction(cancel)
            
            let photoAction = UIAlertAction(title: "从相册选择", style: .default) { [weak self](action) in
                self?.photoLibraryIsNotAuthorizedAndShowAlert(completion: { (needAlert) in
                    if needAlert == false {
                        return
                    }else {
                        self?.imagePicker.sourceType = .photoLibrary
                        self?.imagePicker.delegate = self
                        self?.imagePicker.allowsEditing = self!.allowsEditing!
                        self?.imagePicker.navigationBar.tintColor = UIColor.red
                        self?.superViewController?.present(self!.imagePicker, animated: true, completion: {
                            UIApplication.shared.setStatusBarStyle(.default, animated: true)
                        })
                    }
                })
            }
            alertVC.addAction(photoAction)
            let cameraAction = UIAlertAction(title: "拍照", style: .default) { [weak self](action) in
                self?.cameraIsNotAuthorizedAndShowAlert(completion: { (needAlert) in
                    if needAlert == false {
                        return
                    }else {
                        self?.imagePicker.sourceType = .camera
                        self?.imagePicker.delegate = self
                        self?.imagePicker.allowsEditing = self!.allowsEditing!
                        self?.imagePicker.navigationBar.tintColor = UIColor.red
                        self?.superViewController?.present(self!.imagePicker, animated: true, completion: {
                            UIApplication.shared.setStatusBarStyle(.default, animated: true)
                        })
                    }
                })
            }
            alertVC.addAction(cameraAction)
            
            self.superViewController?.present(alertVC, animated: true, completion: nil)
            
        break
            
        case .photoLibrary:
            photoLibraryIsNotAuthorizedAndShowAlert { [weak self](needAlert) in
                if needAlert == false {
                    return
                }else {
                    self?.imagePicker.sourceType = .photoLibrary
                    self?.imagePicker.delegate = self
                    self?.imagePicker.allowsEditing = self!.allowsEditing!
                    self?.imagePicker.navigationBar.tintColor = UIColor.red
                    self?.superViewController?.present(self!.imagePicker, animated: true, completion: {
                        UIApplication.shared.setStatusBarStyle(.default, animated: true)
                    })
                }
            }
        break
        case .shot:
            cameraIsNotAuthorizedAndShowAlert { [weak self](needAlert) in
                if needAlert == false {
                    return
                }else {
                    self?.imagePicker.sourceType = .camera
                    self?.imagePicker.delegate = self
                    self?.imagePicker.allowsEditing = self!.allowsEditing!
                    self?.imagePicker.navigationBar.tintColor = UIColor.red
                    self?.superViewController?.present(self!.imagePicker, animated: true, completion: {
                        UIApplication.shared.setStatusBarStyle(.default, animated: true)
                    })
                }
            }
        break
            
        }
    }
    
}

extension DeviceAuthorizationHelper:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if allowsEditing == true {
            image = info[.editedImage] as? UIImage
        }else {
            image = info[.originalImage] as? UIImage
        }
        guard let image = image else {
            return
        }
        delegate?.imageDidChooseFinished(image: image)
        
        picker.dismiss(animated: true) {
            guard let completion = self.photoCompletion else {return}
            completion(image,false)
            self.imagePicker.delegate = nil
        }
    }
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imageDidChooseCancle()
        guard let completion = self.photoCompletion else {return}
        completion(UIImage(named: "")!,false)
        picker .dismiss(animated: true) {
            self.imagePicker.delegate = nil
        }
    }
}

extension DeviceAuthorizationHelper {
    private func getAuthorizationBoolStatus(status:AuthorizationStatus) -> Bool {
        if status == .Authorized {
            return true
        }else {
            return false
        }
    }
    
    func selectCompletion(completion:photoSelectCompletion?) {
        self.photoCompletion = completion
    }
}
