//
//  Extension+UIButton.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

// MARK: UIButton
extension UIButton{
    
    //Set Button Icon
    public func setFAIcon(_ fa:fontawesome, color:UIColor?, forState state: UIControlState){
        
        if let font = fontAwesome {
            
            let attributedString = NSAttributedString(string: fa.text!,attributes: [NSAttributedStringKey.foregroundColor : color ?? self.tintColor!])
            
            self.titleLabel?.font = font
            self.setAttributedTitle(attributedString, for: state)
        }
    }
}
