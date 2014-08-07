//
//  SepiaImageView.swift
//  Week3App
//
//  Created by Bradley Johnson on 8/7/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit

@IBDesignable class SepiaImageView: UIImageView {
    
    var filter = CIFilter(name: "CISepiaTone")
    
    @IBInspectable var sepiaIntensity : CGFloat = 1.0 {
        didSet {
            filter.setValue(self.coreImageBackImage(), forKey: kCIInputImageKey)
            filter.setValue(sepiaIntensity, forKey: kCIInputIntensityKey)
            self.image = UIImage(CIImage: filter.outputImage)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.layer.masksToBounds = true
            self.layer.setNeedsDisplay()
        }
        willSet {
            if borderWidth < 0.0 {
                self.borderWidth = 0.0
                self.layer.borderWidth = 0.0
            }
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.blackColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
            self.layer.masksToBounds = true
            self.layer.setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.setNeedsDisplay()
        }
    }
    
    func coreImageBackImage() -> CIImage {
        return CIImage(CGImage: self.image.CGImage)
    }
}
