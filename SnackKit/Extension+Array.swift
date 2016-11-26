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
    
    public mutating func remove(_ object: Element) {
        
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}
