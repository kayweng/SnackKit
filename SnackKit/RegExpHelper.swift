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
        
        let matches:NSArray = internalExpression.matches(in: input, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, input.characters.count)) as NSArray
        
        return matches.count > 0
    }
    
    public static func testMaxlength(_ input:String,max:Int) -> Bool{
        
        func indexOf(_ input:String, findString:String)->Int{
            if let range = input.range(of: findString){
                return input.characters.distance(from: input.startIndex, to: range.lowerBound)
            }
            
            return 0
        }
        
        let index = input.characters.index(input.startIndex, offsetBy: indexOf(input, findString: "."))
        let newInput = input.substring(to: index) == "" ? input:input.substring(to: index)
        
        let maxexp =  RegExp.Maxlength.rawValue.replacingOccurrences(of: "MAXLENGTH", with: "\(10)")
        
        let internalExpression: NSRegularExpression  = try! NSRegularExpression(pattern: maxexp, options: .caseInsensitive)
        
        let matches:NSArray = internalExpression.matches(in: newInput, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSMakeRange(0, newInput.characters.count)) as NSArray
        
        return matches.count > 0
    }
}
