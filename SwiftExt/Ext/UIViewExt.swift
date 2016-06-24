//
//  UIViewExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

extension CALayer {
    func x()->CGFloat
    {
        
        return self.frame.origin.x
    }
    func right()-> CGFloat
    {
        return self.frame.origin.x + self.frame.size.width
    }
    func y()->CGFloat
    {
        return self.frame.origin.y
    }
    func bottom()->CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    func width()->CGFloat
    {
        return self.frame.size.width
    }
    func height()-> CGFloat
    {
        return self.frame.size.height
    }
    
    func setX(x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setRight(right: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(y: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(bottom: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(width: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(height: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    func centerX()-> CGFloat {
        return self.position.x
    }
    
    func centerY()-> CGFloat {
        return self.position.y
    }
    
    func setCenterX(centerX: CGFloat) {
        self.position = CGPointMake(centerX, self.position.y)
    }
    
    func setCenterY(centerY: CGFloat) {
        self.position = CGPointMake(self.position.x, centerY)
    }
}

extension UIView {
    
    func x()->CGFloat
    {
        return self.frame.origin.x
    }
    func right()-> CGFloat
    {
        return self.frame.origin.x + self.frame.size.width
    }
    func y()->CGFloat
    {
        return self.frame.origin.y
    }
    func bottom()->CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    func width()->CGFloat
    {
        return self.frame.size.width
    }
    func height()-> CGFloat
    {
        return self.frame.size.height
    }
    
    func setX(x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setRight(right: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(y: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(bottom: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(width: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(height: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    func centerX()-> CGFloat {
        return self.center.x
    }
   
    func centerY()-> CGFloat {
        return self.center.y
    }
    
    func setCenterX(centerX: CGFloat) {
        self.center = CGPointMake(centerX, self.center.y)
    }
    
    func setCenterY(centerY: CGFloat) {
        self.center = CGPointMake(self.center.x, centerY)
    }
    
    func appRootViewController() -> UIViewController? {
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
    
    func appCurrentViewController() -> UIViewController? {
        var result: UIViewController? = nil
        var window = UIApplication.sharedApplication().keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.sharedApplication().windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindowLevelNormal {
                    window = tmpWin
                    break
                }
            }
        }
        
        let frontView = window?.subviews[0]
        let nextResponder = frontView?.nextResponder()
        if ((nextResponder?.isKindOfClass(UIViewController.classForCoder())) != nil) {
            result = nextResponder as? UIViewController
        } else {
            result = window?.rootViewController
        }
        return result
    }
}