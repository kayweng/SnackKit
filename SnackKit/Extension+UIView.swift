//
//  Extension+UIView.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
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


// MARK : UIView
extension UIView {
    
    public class func loadNib(owner ownerOrNil:AnyObject?, nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: ownerOrNil, options: nil)[0] as? UIView
    }
    
    public func disabled(){
        
        for input in self.subviews{
            
            if input is UITextField{
                let txt = input as! UITextField
                txt.isEnabled = false
                txt.isUserInteractionEnabled = false
            }
            
            if input is UISwitch{
                let sw = input as! UISwitch
                sw.isEnabled = false
                sw.isUserInteractionEnabled = false
            }
            
        }
    }
    
    public func reset(){
        
        for ctrl in self.subviews{
            //UITextField
            if ctrl.isKind(of: UITextField.self){
                (ctrl as! UITextField).text = nil
            }
            //Switch
            if ctrl.isKind(of: UISwitch.self){
                (ctrl as! UISwitch).isOn = false
            }
        }
    }
    
    public func underlined(width:CGFloat, color:UIColor? = nil){
        
        let border = CALayer()
        
        border.borderColor = color?.cgColor ?? UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    public func removeUnderline(at width:CGFloat){
        
        if self.layer.sublayers?.count > 0 {
         
            for layer in self.layer.sublayers! {
                
                if layer.borderWidth == width{
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    public func corner(rounding corners:UIRectCorner, size:CGSize? = CGSize(width: 10.0, height: 10.0) ){
        
        let cornerBound:CGRect = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: self.bounds.height)
        
        let corner = UIBezierPath(roundedRect: cornerBound, byRoundingCorners: corners, cornerRadii: size!)
        
        let shape = CAShapeLayer()
        shape.path = corner.cgPath
        
        self.layer.mask = shape
        
    }

    public func circle(radius:CGFloat? = 0,color:UIColor = UIColor.darkGray, width:CGFloat = CGFloat(0.5)){
        
        self.clipsToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        
        if let r = radius , radius > 0{
            self.layer.cornerRadius = r
        }else{
            self.layer.cornerRadius = self.frame.size.width/2
        }
    }
    
    public func addGradient(colors:[AnyObject],at locations:[NSNumber]? = [0.1,1.0]){
        
        if self.isKind(of: UICollectionView.self){
            let coll = self as! UICollectionView
            
            if coll.backgroundView == nil{
                let vw = UIView(frame: self.frame)
                vw.addGradientLayers(colors: colors, at: locations)
                
                coll.backgroundView = vw
                sendSubview(toBack: vw)
                
            }else{
                self.addGradientLayers(colors: colors, at: locations)
            }
        }
    }
    
    public func addGradientLayers(colors:[AnyObject],at locations:[NSNumber]? = [0.1,1.0]){
        
        let gradient: CAGradientLayer = CAGradientLayer()
    
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.locations = locations
    
        if let sub = self.layer.sublayers{
            if sub[0].isKind(of: CAGradientLayer.self){
                self.layer.sublayers?.removeFirst()
            }
        }

        self.layer.insertSublayer(gradient, at: 0)
    }
    
    public func transiteFromTop(duration:CFTimeInterval){
        
        let animation:CATransition = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        
        self.layer.add(animation, forKey: kCATransitionPush)
    }

}


