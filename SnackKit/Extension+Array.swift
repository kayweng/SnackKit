//
//  Extension+Array.swift
//  SnackExtension
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

// MARK: - Array
extension Array where Element : Equatable {
    
    public mutating func remove(_ member: Element) -> Element? {
        
        if let index = self.index(of: member) {
            self.remove(at: index)
            return member
        }
        
        return nil
    }
}
