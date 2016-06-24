//
//  NSTimerExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

public typealias TimerExcuteClosure = @convention(block)()->()

extension NSTimer{
    //NSTimer 不会对控制器强引用，不需要手动释放NSTimer
    public class func scheduledTimerWithTimeInterval(ti:NSTimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> NSTimer{
        return self.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.excuteTimerClosure(_:)), userInfo: unsafeBitCast(closure, AnyObject.self), repeats: yesOrNo)
    }
    
    class func excuteTimerClosure(timer: NSTimer)
    {
        let closure = unsafeBitCast(timer.userInfo, TimerExcuteClosure.self)
        closure()
    }
}