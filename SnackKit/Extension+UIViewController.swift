//
//  Extension+UIViewController.swift
//  PocketMerchant
//
//  Created by kay weng on 23/08/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

extension UIViewController{

    public var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    public func alertRequire(for target:AnyObject)->Bool{
        
        let mandatory_title =  "Application"
        var mandatory_message = "Mandatory Field";
        
        //UITextField
        if let obj = target as? UITextField {
            if obj.text!.characters.count == 0 {
                
                if let o = obj.placeholder{
                    mandatory_message = o + " is mandatory!";
                }
                
                alert(title: mandatory_title, message: mandatory_message,control:obj);
                
                return true
            }
        }
        
        return false
        
    }
    
    public func alert(title:String, message:String, actions:Array<UIAlertAction>, textfields:Array<UITextField>) -> UIAlertController{
        
        let alert = UIAlertController(title: title
            , message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        for _:UITextField in textfields{
            alert.addTextField(configurationHandler: { (textField: UITextField!) in
                textField.autocapitalizationType = .words
            })
        }
        
        for action:UIAlertAction in actions{
            alert.addAction(action)
        }
        
        self.present(alert, animated: true) { () -> Void in
            //Do more
        }
        
        return alert
    }
    
    public func alertWithView(_ subview:UIView){
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.view.addSubview(subview)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //- display in action style with multiple actions
    public func alert(title:String, message:String, style:UIAlertControllerStyle, actions:Array<UIAlertAction>){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action:UIAlertAction in actions{
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //- display in alert style with OK
    public func alert(title:String, message:String, control:UITextField){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action -> Void in
            control.becomeFirstResponder()
        });
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    public func alert(title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action -> Void in
              //continue here
        });
        
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil);
    }
}
