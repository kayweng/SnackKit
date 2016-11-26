//
//  Extension+Double.swift
//  SnackExtension
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

// MARK: - Double
extension Double {
    
    public var negative: Double{
        return NSDecimalNumber(value: 0 as Int32).subtracting(NSDecimalNumber(value: self as Double)).doubleValue
    }
    
    public var positive: Double{
        return NSDecimalNumber(value: self * -1 as Double).doubleValue
    }
}
