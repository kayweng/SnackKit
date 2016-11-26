//
//  Extension+UITextView.swift
//  PocketMerchant
//
//  Created by kay weng on 01/09/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


extension UITextView{

    public func normal(_ text:String, size:CGFloat? = nil){
        
        let txt = self.text == text ? self.text : text
        let attrs:DictionaryResult = [NSFontAttributeName : UIFont.systemFont(ofSize: size ?? self.font!.pointSize)]
        let normalString = NSMutableAttributedString(string: txt!, attributes: attrs)
        
        self.attributedText = normalString
    }
    
    public func bold(_ text:String,rangeText:[String]? = nil, size:CGFloat? = nil, alignment:NSTextAlignment? = NSTextAlignment.left){
        
        let attributedText = NSMutableAttributedString(string: text)

        if rangeText?.count > 0 {
            
            for txt in rangeText!{
                
                attributedText.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: size!)], range: (text as NSString).range(of: txt))
            }
            
        }else{
            
            attributedText.addAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: size!)], range: (text as NSString).range(of: text))
        }
        
        self.textAlignment = alignment!
        self.attributedText = attributedText
    }

}
