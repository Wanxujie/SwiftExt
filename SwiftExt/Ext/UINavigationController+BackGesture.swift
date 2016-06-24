//
//  UINavigationController+BackGesture.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

var assoKeyPanGesture = "__yrakpanges"
var assoKeyStartPanPoint = "__yrakstartp"
var assoKeyEnableGesture = "__yrakenabg"

let BackGestureOffsetXToBack: CGFloat = 80
extension UINavigationController: UIGestureRecognizerDelegate{
    // Object-C: https://github.com/YueRuo/UINavigationController-YRBackGesture/blob/master/YRBackGesture/UINavigationController%2BYRBackGesture.m
    
    func enableBackGesture() -> Bool {
        let enableGestureNum: NSNumber? = objc_getAssociatedObject(self, &assoKeyEnableGesture) as? NSNumber
        if enableGestureNum != nil {
            return enableGestureNum!.boolValue
        }
        return false
    }
    
    func setEnableBackGesture(enableBackGesture: Bool) {
        let enableGestureNum = NSNumber(bool: enableBackGesture)
        objc_setAssociatedObject(self, &assoKeyEnableGesture, enableGestureNum, .OBJC_ASSOCIATION_RETAIN)
        if (enableBackGesture == true) {
            self.view.addGestureRecognizer(self.panGestureRecognizer())
        }else{
            self.view.removeGestureRecognizer(self.panGestureRecognizer())
        }
    }
    
    func panGestureRecognizer() -> UIPanGestureRecognizer {
        var panGestureRecognizer = objc_getAssociatedObject(self, &assoKeyPanGesture) as? UIPanGestureRecognizer
        if panGestureRecognizer != nil {
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(UINavigationController.panToBack(_:)))
            panGestureRecognizer?.delegate = self
            objc_setAssociatedObject(self, &assoKeyPanGesture, panGestureRecognizer, .OBJC_ASSOCIATION_RETAIN)
        }
        return panGestureRecognizer!
    }
    
    func setStartPanPoint(point: CGPoint) {
        let startPanPointValue = NSValue.init(CGPoint: point)
        objc_setAssociatedObject(self, &assoKeyStartPanPoint, startPanPointValue, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func startPanPoint() -> CGPoint {
        let startPanPointValue = objc_getAssociatedObject(self, &assoKeyStartPanPoint) as? NSValue
        if startPanPointValue == nil {
            return CGPointZero
        }
        return startPanPointValue!.CGPointValue()
    }
    
    func panToBack(pan: UIPanGestureRecognizer) {
        
        let currentView: UIView = self.topViewController!.view
        if (self.panGestureRecognizer().state == UIGestureRecognizerState.Began) {
            self.setStartPanPoint(currentView.frame.origin)
            let velocity: CGPoint = pan.velocityInView(self.view)
            if(velocity.x != 0){
                self.willShowPreViewController()
            }
            return
        }
        let currentPostion: CGPoint = pan.translationInView(self.view)
        var xoffset: CGFloat = self.startPanPoint().x + currentPostion.x
        let yoffset: CGFloat = self.startPanPoint().y + currentPostion.y
        if (xoffset>0) {//向右滑

        }else if(xoffset<0){//向左滑
        if (currentView.frame.origin.x>0) {
            xoffset = xoffset < -self.view.frame.size.width ? -self.view.frame.size.width : xoffset
        }else{
            xoffset = 0
        }
    }
    if (!CGPointEqualToPoint(CGPointMake(xoffset, yoffset), currentView.frame.origin)) {
    
        if (xoffset <= 0) {//修复滑动过程中快速左滑会出现偏移或闪屏的bug
            xoffset = 0
        }
            self.layoutCurrentViewWithOffset(UIOffsetMake(xoffset, yoffset))
        }
        if (self.panGestureRecognizer().state == .Ended) {
            if (currentView.frame.origin.x==0) {
            }else{
                if (currentView.frame.origin.x < BackGestureOffsetXToBack){
                    self.hidePreViewController()
                }else{
                    self.showPreViewController()
                }
            }
        }
    }
    
    func willShowPreViewController() {
        let count: NSInteger = self.viewControllers.count
        if (count > 1) {
            let currentVC:UIViewController = self.topViewController!
            let preVC: UIViewController = self.viewControllers[count - 2]
            currentVC.view.superview?.insertSubview(preVC.view, belowSubview: currentVC.view)
        }
    }
    func showPreViewController() {
        let count: NSInteger = self.viewControllers.count
        if (count > 1) {
            let currentView: UIView = self.topViewController!.view
            var animatedTime: CGFloat = 0
            animatedTime = abs(self.view.frame.size.width - currentView.frame.origin.x) / self.view.frame.size.width * CGFloat(0.35)
            UIView.setAnimationCurve(.EaseInOut)
            UIView.animateWithDuration(NSTimeInterval(animatedTime), animations: { () -> Void in
                self.layoutCurrentViewWithOffset(UIOffsetMake(self.view.frame.size.width, 0))
                }, completion: { (Bool) -> Void in
                self.popViewControllerAnimated(false)
            })
        }
    }
    
    func hidePreViewController() {
        let count: NSInteger = self.viewControllers.count
        if (count > 1) {
            let preVC: UIViewController = self.viewControllers[count - 2]
            let currentView: UIView = self.topViewController!.view
            var animatedTime: CGFloat = 0
        animatedTime = abs(self.view.frame.size.width - currentView.frame.origin.x) / self.view.frame.size.width * 0.35
        UIView.setAnimationCurve(.EaseInOut)
            UIView.animateWithDuration(NSTimeInterval(animatedTime), animations: { () -> Void in
                self.layoutCurrentViewWithOffset(UIOffsetMake(0, 0))
                }, completion: { (Bool) -> Void in
                    preVC.view.removeFromSuperview()
            })
        }
    }
    
    func layoutCurrentViewWithOffset(offset: UIOffset) {
        let count: NSInteger = self.viewControllers.count
        if (count>1) {
        let currentVC: UIViewController = self.topViewController!
        let preVC: UIViewController = self.viewControllers[count - 2]
        currentVC.view.frame = CGRectMake(offset.horizontal, self.view.bounds.origin.y, self.view.frame.size.width, currentVC.view.frame.size.height)
        preVC.view.frame = CGRectMake(offset.horizontal/2-self.view.frame.size.width/2, self.view.bounds.origin.y, self.view.frame.size.width, preVC.view.frame.size.height)
        }
    }
    
    public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.panGestureRecognizer()) {
            
            let panGesture: UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            
            let translation: CGPoint = panGesture.translationInView(self.view)
            if (panGesture.velocityInView(self.view).x < 600 && abs(translation.x) / abs(translation.y)>1) {
                return true
            }
            return false
        }
        return true
    }
    
    
}
