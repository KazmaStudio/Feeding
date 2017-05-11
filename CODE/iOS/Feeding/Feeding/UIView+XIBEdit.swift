//
//  UIView+XIBEdit.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/10.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > CGFloat(INT_0)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > CGFloat(INT_0)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var onePXBorder: Bool {
        get{
            return false
        }
        set {
            if(newValue){
                self.borderWidth = ONE_PIXEL
            }
        }
    }
    
    @IBInspectable var borderTop: Bool {
        get{
            return false
        }
        set {
            if(newValue){
                self.layoutSubviews();
                let topBorder: CALayer = CALayer()
                topBorder.frame = CGRect(x: CGFloat(INT_0), y: CGFloat(INT_0), width: SCREEN_WIDTH, height: ONE_PIXEL)
                topBorder.backgroundColor = COLOR_BOARD_GRAY.cgColor
                self.layer.addSublayer(topBorder)
            }
        }
    }
    
    @IBInspectable var borderBottom: Bool {
        get{
            return false
        }
        set {
            if(newValue){
                self.layoutSubviews();
                let bottomBorder: CALayer = CALayer()
                bottomBorder.frame = CGRect(x: CGFloat(INT_0), y: self.frame.height - ONE_PIXEL, width: SCREEN_WIDTH, height: ONE_PIXEL)
                bottomBorder.backgroundColor = COLOR_BOARD_GRAY.cgColor
                self.layer.addSublayer(bottomBorder)
            }
        }
    }
}
