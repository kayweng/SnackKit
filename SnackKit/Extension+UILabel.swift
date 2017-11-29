//
//  Extension+UILabel.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//


import UIKit

// MARK: UILabel
extension UILabel{
    
    public func setFAIcon(_ fa:fontawesome, color:UIColor? = nil, size:CGFloat? = nil){
    
        if let font = fontAwesome {
            self.font = font
            self.text = fa.text
            self.textColor = color ?? self.textColor
            self.font.withSize(size ?? self.font.pointSize)
        }
    }
    
    public func setFAIcon(_ fa:fontawesome, color:UIColor? = nil, bgColor:UIColor? = nil, border:(CGFloat,UIColor)?)
    {
        if let font = fontAwesome {
            self.font = font
            self.text = fa.text
            self.textColor = color ?? self.textColor
            self.backgroundColor = bgColor ?? self.backgroundColor

            self.layer.cornerRadius = self.frame.size.width/2
            self.layer.masksToBounds = true
            self.layer.borderWidth = border?.0 ?? 1.0
            self.layer.borderColor = border?.1.cgColor ?? UIColor.white.cgColor
        }
    }
    
    //Note, this method is merely highlight a label which end with *
    public func asterikHighlight(color:UIColor? = UIColor.orange){
        
        let newString = NSMutableAttributedString(string: self.text!)
        
        newString.addAttribute(NSAttributedStringKey.foregroundColor, value: color!, range: NSRange(location:self.text!.count-1,length:1))
        
        self.attributedText = newString

    }
    
    //Resize Label
    public func resizeToFit(){
        
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.frame = CGRect(origin: self.frame.origin, size: self.intrinsicContentSize)
    }
    
    //Set to bold text
    public func bold(_ text:String? = "",color:UIColor? = nil,size:CGFloat? = nil){
        
        let txt = text!.count > 0 ? text : self.text!
        let attrs = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size ?? self.font.pointSize)]
        let boldString = NSMutableAttributedString(string: txt!, attributes: attrs)
       
        self.attributedText = boldString
    }

}
