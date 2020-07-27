//
//  STLUtils.swift
//  TestForLearn
//
//  Created by Qu,Ke on 2020/7/15.
//  Copyright © 2020 baidu. All rights reserved.
//

import UIKit

@objcMembers
class STLUtils : NSObject {
    
    let myValue = 2;
    

    class func imageMemoryLength(image : UIImage) -> Int {
        
//        let cgImage = image.cgImage
//
//        if let tmpImage = cgImage {
//
//            let bytesperRow : Int = tmpImage.bitsPerPixel
//
//            return Int(tmpImage.width) * Int(tmpImage.height) * bytesperRow / 8
//
//        } else {
//
//            return 0
//
//        }
        
        return Int(TLUtils.imageMemoryLength(image))
    }
    
    static func scaleImageToSize(image : UIImage, widthAndHeigth : CGFloat) -> UIImage? {
        
        let  size = CGSize(width: widthAndHeigth, height: widthAndHeigth)
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        
        var x, y, w, h : CGFloat
        
        let imageW :Int! = image.cgImage?.width
        let imageH :Int! = image.cgImage?.height
        
        if imageH == 0 || imageW == 0 {
            return nil
        }
        
        if imageW > imageH {
            
            w = CGFloat(imageW / imageH) * widthAndHeigth
            h = widthAndHeigth
            x = (widthAndHeigth - w ) / 2
            y = 0
            
        } else {
            
            h = CGFloat(imageH / imageW) * widthAndHeigth
            w = widthAndHeigth
            y = (widthAndHeigth - h) / 2
            x = 0
            
        }
        

        image.draw(in: CGRect.init(x: x, y: y, width: w, height: h))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaleImage!
        
    }
        
}
