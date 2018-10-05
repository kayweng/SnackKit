//
//  Extension+UITableView.swift
//  PocketMerchant
//
//  Created by kay weng on 11/05/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

// MARK: - UITableView Extension
extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }, completion: { _ in completion() })
    }
    
    public func hideSearchBar() {
        
        if let bar = self.tableHeaderView as? UISearchBar {

            if self.contentOffset.y < bar.frame.height {
                self.contentOffset = CGPoint(x: 0, y: bar.frame.height)
            }
        }
    }
    
    public func scrollToTop(animated: Bool, offSet:CGFloat? = 44) {
        self.setContentOffset(CGPoint(x: 0,y: offSet!), animated: animated)
    }
    
    public func noResultFound(_ hasRecord:Bool, image name:String, message:String = "No Record Found"){
        
        let bgView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width,height: self.bounds.size.height))
        let emptyImage:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 64,height: 64))
        let emptyMessage:UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.bounds.size.width,height: 30))
        
        emptyImage.center = CGPoint(x: bgView.center.x, y: bgView.center.y - 20)
        emptyImage.image = UIImage(named: name)
    
        emptyMessage.center = CGPoint(x: bgView.center.x, y: bgView.center.y + 20)
        emptyMessage.text = message
        emptyMessage.textAlignment = .center
        emptyMessage.font = UIFont.systemFont(ofSize: CGFloat(12.0))
        
        bgView.addSubview(emptyImage)
        bgView.addSubview(emptyMessage)
        
        self.isScrollEnabled = hasRecord
        self.backgroundView = hasRecord ? nil : bgView
        self.separatorStyle = hasRecord ? .singleLine : .none
    }
    
    public func updateRows(at indexPath:[IndexPath], action: TableAction, animated:UITableView.RowAnimation? = UITableView.RowAnimation.automatic){
        
        self.beginUpdates()
        
        switch action{
            
        case .Insert:
            self.insertRows(at: indexPath, with: animated!)
        case .Update:
            self.reloadRows(at: indexPath, with: animated!)
        case .Delete:
            self.deleteRows(at: indexPath, with: animated!)
        default:
            NSLog("No Action Required !")
        }
        
        self.endUpdates()
    }
    
    public func removeSections(at sections:[Int],animated: UITableView.RowAnimation? = UITableView.RowAnimation.automatic){
        
        for section in sections{
            self.deleteSections(IndexSet(integer: section), with: animated!)
        }
    }
    
    public func reloadSections(at sections:[Int], animated:UITableView.RowAnimation? = UITableView.RowAnimation.none){
        
        self.reloadData()
        
        for section in sections{
            self.reloadSections(IndexSet(integer: section), with: animated!)
        }
    }
    
    public func setGradientWith(colors:[AnyObject],at locations:[Double]? = [0.0,1.0]){
        
        let gradientBackgroundColors = colors
        let gradientLocations = locations
        let backgroundView = UIView(frame: self.bounds)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.bounds
        
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.backgroundView = backgroundView
    }

    public func setBackground(image imageFile:String){
        self.backgroundView = UIImageView(image: UIImage(named:imageFile)!)
    }

    public func defaultCellHeight()->CGFloat{
        return CGFloat(44.0)
    }
}
