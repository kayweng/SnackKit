//
//  Extension+UITextField.swift
//  PocketMerchant
//
//  Created by kay weng on 12/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

extension UITextField{
    
    public func returnKey(in controller:UIViewController, type:UIReturnKeyType = .done){
        
        func dismissKeyboard(){
            controller.view.endEditing(true)
        }
        
        self.returnKeyType = type
        self.addTarget(controller, action: #selector(UIInputViewController.dismissKeyboard), for: UIControlEvents.editingDidEndOnExit)
    }
    
    public func clear(){
        self.text? = ""
    }
    
    public func decimal(){
        
        if let text = self.text?.double{
            
            let numberFormatter = NumberFormatter()
            
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            
            self.text = numberFormatter.string(from: NSNumber(value: text))
        }
    }
    
    public func normal(_ text:String? = "", size:CGFloat? = nil){
        
        let txt = text!.characters.count > 0 ? text : self.text!
        let attrs:DictionaryResult = [NSFontAttributeName : UIFont.systemFont(ofSize: size ?? self.font!.pointSize)]
        let normalString = NSMutableAttributedString(string: txt!, attributes: attrs)
        
        self.attributedText = normalString
    }
    
    public func bold(_ text:String? = "", size:CGFloat? = nil){
        
        let txt = text!.characters.count > 0 ? text : self.text!
        let attrs:DictionaryResult = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: size ?? self.font!.pointSize)]
        let boldString = NSMutableAttributedString(string: txt!, attributes: attrs)
        
        self.attributedText = boldString
    }
    
    public func italic(_ text:String? = "", size:CGFloat? = nil){
        
        let txt = text!.characters.count > 0 ? text : self.text!
        let attrs:DictionaryResult = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: size ?? self.font!.pointSize)]
        let italicString = NSMutableAttributedString(string: txt!, attributes: attrs)
        
        self.attributedText = italicString
    }
}
