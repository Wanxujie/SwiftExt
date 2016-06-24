//
//  UILableExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

extension UILabel {
    class func labelWithFrame(frame: CGRect, text: String, textColor: UIColor, font: UIFont, tag: Int, hasShadow: Bool) -> UILabel! {
        let label = UILabel(frame: frame)
        label.text = text
        label.textColor = textColor
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = font
        label.tag = tag
        
        if hasShadow == true {
            label.shadowColor = UIColor.blackColor()
            label.shadowOffset = CGSizeMake(1, 1)
        }
        
        return label
    }
 
    class func labelForNavigationBarWithTitle(title: String, textColor: UIColor, font: UIFont, hasShadow: Bool) -> UILabel! {
        let label = UILabel.labelWithFrame(CGRectMake(0, 0, 320, 44), text: title, textColor: textColor, font: font, tag: 0, hasShadow: hasShadow)
        label.textAlignment = NSTextAlignment.Center
        
        return label
    }
    
    class func labelWithFrame(frame: CGRect, textColor: UIColor, font: UIFont) -> UILabel! {
        let label = UILabel(frame: frame)
        label.font = font
        label.textColor = textColor
        label.backgroundColor = UIColor.clearColor()
        
        return label
    }

    class func labelWithFrame(frame: CGRect, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment) -> UILabel! {
        let label = UILabel.labelWithFrame(frame, textColor: textColor, font: font)
        label.textAlignment = textAlignment
        
        return label
    }
    
    class func labelWithFrame(frame: CGRect, backgroundColor: UIColor, font: UIFont) -> UILabel! {
        let label = UILabel(frame: frame)
        label.backgroundColor = backgroundColor
        label.font = font
        
        return label
    }}
