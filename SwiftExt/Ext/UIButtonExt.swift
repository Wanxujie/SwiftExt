//
//  UIButtonExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

public var EnlargedRectTopNameKey = Character("a")
public var EnlargedRectRightNameKey = Character("b")
public var EnlargedRectBottomNameKey = Character("c")
public var EnlargedRectLeftNameKey = Character("d")

extension UIButton {

    class func buttonWithFrame(frame: CGRect, image: UIImage?, tappedImage: UIImage?, target: AnyObject, action:Selector) -> UIButton {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = frame
        
        if let imag = image {
            button.setImage(imag, forState: UIControlState.Normal)
        }
        
        if let imag = tappedImage {
            button.setImage(imag, forState: UIControlState.Selected)
            button.setImage(imag, forState: UIControlState.Highlighted)
        }
        
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func setEnlargeEdge(edge: Float) {
        self.setEnlargeEdgeWithTop(edge, right: edge, bottom: edge, left: edge)
    }
    
    func getEnlargeEdge() -> CGFloat {
        let topEdge: NSNumber? = objc_getAssociatedObject(self, &EnlargedRectTopNameKey) as? NSNumber
        if topEdge != nil {
            return CGFloat((topEdge?.floatValue)!)
        } else {
            return 0
        }
    }
    
    /**
     set Enlarge edge  设置点击范围
     
     - parameter top:    top
     - parameter right:  right
     - parameter bottom: bottom
     - parameter left:   left
     */
    func setEnlargeEdgeWithTop(top: Float, right: Float, bottom:Float, left:Float) {
        objc_setAssociatedObject(self, &EnlargedRectTopNameKey, NSNumber(float: top) ,objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargedRectRightNameKey, NSNumber(float: right),objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargedRectBottomNameKey, NSNumber(float: bottom),objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &EnlargedRectLeftNameKey, NSNumber(float: left),objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func enlargedRect() -> CGRect {
        
        let topEdge: NSNumber? = objc_getAssociatedObject(self, &EnlargedRectTopNameKey) as? NSNumber
        let rightEdge: NSNumber? = objc_getAssociatedObject(self, &EnlargedRectRightNameKey) as? NSNumber
        let bottomEdge: NSNumber? = objc_getAssociatedObject(self, &EnlargedRectBottomNameKey) as? NSNumber
        let leftEdge: NSNumber? = objc_getAssociatedObject(self, &EnlargedRectLeftNameKey) as? NSNumber
        
        if (topEdge != nil && rightEdge != nil && bottomEdge != nil && leftEdge != nil) {
            return CGRectMake(self.x() - CGFloat(leftEdge!.floatValue), self.y() - CGFloat(topEdge!.floatValue), self.width() + CGFloat(leftEdge!.floatValue + rightEdge!.floatValue), self.height() + CGFloat(topEdge!.floatValue + bottomEdge!.floatValue))
        } else {
            return self.bounds
        }
    }
    
    override public func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let rectBig = CGRectInset(self.bounds, -(self.getEnlargeEdge()), -(self.getEnlargeEdge()))
        return CGRectContainsPoint(rectBig, point) ? self : nil
    }

}