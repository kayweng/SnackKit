//
//  Extension+UIBarButtonItem.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

// MARK: UIButton
extension UIBarButtonItem{
    
    //Set Icon to BarButtonItem
    public func setFAIcon(_ fa:fontawesome){
        
        if let font = fontAwesome {
            self.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State())
            self.title = fa.text
        }
    }
}
