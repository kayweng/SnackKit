//
//  RegExpHelper.swift
//  SnackKit
//
//  Created by kay weng on 20/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public enum RegExp:String{
    
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case Amount = "^-*\\d+(\\.\\d{0,2})?$"
    case Phone = "[0-9]{8,14}"
    case Maxlength = "^[\\s\\S]{0,MAXLENGTH}$"
    case Rate = "^(?:100|\\d{1,2}+|\\d{1,2}+[.]\\d{0,2}+)%?$"
}

infix operator =~

public class RegExpHelper {
    
    public var error: NSError?
    
    public static func test(_ input: String, pattern:RegExp) -> Bool {
        
        let internalExpression: NSRegularExpression  = try! NSRegularExpression(pattern: pattern.rawValue, options: .caseInsensitive)
        
        let matches:NSArray = internalExpression.matches(in: input, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, input.count)) as NSArray
        
        return matches.count > 0
    }
    
    public static func testMaxlength(_ input:String,max:Int) -> Bool{
        
        let index = input.index(input.startIndex, offsetBy: input.indexOf("."))
        let newInput = input[index..<input.endIndex] ==  "" ? input : String(input[index..<input.endIndex])
        
        //let newInput = input.substring(to: index) == "" ? input:input.substring(to: index)
        
        let maxexp =  RegExp.Maxlength.rawValue.replacingOccurrences(of: "MAXLENGTH", with: "\(max)")
        
        let internalExpression: NSRegularExpression  = try! NSRegularExpression(pattern: maxexp, options: .caseInsensitive)
        
        let matches:NSArray = internalExpression.matches(in: newInput, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, newInput.count)) as NSArray
        
        return matches.count > 0
    }
}
