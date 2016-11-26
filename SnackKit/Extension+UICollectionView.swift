//
//  Extension+UICollectionView.swift
//  PocketMerchant
//
//  Created by kay weng on 21/09/2016.
//  Copyright © 2016 pocket-app. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    func setBackground(image imageFile:String){
        self.backgroundView = UIImageView(image: UIImage(named:imageFile))
    }
}
