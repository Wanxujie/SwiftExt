//
//  UIImageViewExt.swift
//  XJShapedButton
//
//  Created by 万旭杰 on 16/6/21.
//  Copyright © 2016年 万旭杰. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func addCorner(radius radius: CGFloat) {
        // if self.image is nil, it doesn't work 
        self.image = self.image?.drawRectWithRadius(radius, size: self.bounds.size)
    }
}
