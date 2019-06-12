//
//  Image-Extension.swift
//  OHFinancialServices
//
//  Created by hoomsun on 2019/5/10.
//  Copyright © 2019 hoomsun. All rights reserved.
//

import UIKit

extension UIImage {
    /// 重设图片大小
    func reSizeImage(reSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        
        let reSizeImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
        
    }
    
    /// 等比例缩放
    func scaleImage(scaleSize:CGFloat) -> UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    /// 生成二维码照片
    static func creatQRCodeImage(url:String,image:UIImage?) -> UIImage {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(url.data(using: String.Encoding.utf8), forKey: "inputMessage")
        if let outputImage = filter?.outputImage {
            let qrCodeImage = creatHigheDefinitionUIimage(outputImage, size: 300)
            if var image = image {
                image = circleImage(image, borderWidth: 10, borderColor: UIColor.white)
                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 100, height: 100)
                return newImage
                
            }
            return qrCodeImage
        }
        return UIImage()
    }
    /// 二维码的生成
    private static func syntheticImage(_ image:UIImage,iconImage:UIImage,width:CGFloat,height:CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    /// 生成高清的UIImage
    private static func creatHigheDefinitionUIimage(_ image:CIImage,size: CGFloat) -> UIImage {
        let integral : CGRect = image.extent.integral
        let proportion : CGFloat = min(size/integral.width, size/integral.height)
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)
        
        let contect = CIContext(options: nil)
        let bitmapImage : CGImage = contect.createCGImage(image, from: integral)!
        
        
        
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none
        bitmapRef?.scaleBy(x: proportion, y: proportion)
        bitmapRef?.draw(bitmapImage, in: integral)
        let image:CGImage = bitmapRef!.makeImage()!
        return UIImage(cgImage: image)
    }
    /// 生成边框
    private static func circleImage(_ sourceImage:UIImage,borderWidth:CGFloat,borderColor:UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width : sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

