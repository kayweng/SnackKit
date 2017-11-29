//
//  Extension+UIImage.swift
//  SnackKit
//
//  Created by kay weng on 29/11/2017.
//  Copyright © 2017 snackcode.org. All rights reserved.
//

import Foundation

extension UIImage{
    
    public func tabBarSelectorIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let cg = CGRect.init(x: 0, y: size.height-lineWidth, width: size.width, height: lineWidth)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        
        UIRectFill(cg)
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
