//
//  Extension+String.swift
//  SnackExtension
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

private var f = "%f"
private var f2 = "%.2f"

extension String {
    
    // MARK: - Properties
    public var bool:Bool?{
        
        switch self
        {
            case "TRUE", "True", "true", "YES", "Yes", "yes", "1":
                return true
            case "FALSE", "False", "false", "NO", "No", "no", "0":
                return false
            default:
                return nil
        }
    }
    
    public var date:Date?{
        return self.isEmpty ? nil :  self.formatToDate()
    }
    
    public var decimal: NSDecimalNumber?{
        return self.isEmpty ? nil : NSDecimalNumber(string: self)
    }
    
    public var double: Double?{
        
        if self.isEmpty {
            return nil
        }
        
        let formatter = NumberFormatter()
        let value = self.replaceOf(",", with: "")
        
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let numberVal:NSNumber = formatter.number(from: value) {
            return (numberVal.stringValue as NSString).doubleValue
        }
        
        return nil
    }
    
    public var number:NSNumber?{
        return self.isEmpty ? nil : NSNumber(value: (self as NSString).doubleValue as Double)
    }
    
    public var int:Int?{
        return self.isEmpty ? nil : (self as NSString).integerValue
    }
    
    public var int32:Int32?{
        return self.isEmpty ? nil : (self as NSString).intValue
    }
    
    // MARK: - Methods
    public func localize(format:String)->String{
        
        let val = (self.replaceOf(",", with: "") as NSString).doubleValue
        
        return String.localizedStringWithFormat(format, val)
    }
    
    public func toDecimal()->String{
        
        let val = (self.replaceOf(",", with: "") as NSString).doubleValue
        
        return indexOf(".") > 0 ? String.localizedStringWithFormat(f2, val) : String.localizedStringWithFormat(f, val)
    }
    
    public func trim()->String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func indexOf(_ findString:String)->Int{
        
        if let range = self.range(of: findString){
            return self.characters.distance(from: self.startIndex, to: range.lowerBound)
        }
       
        return 0
    }
    
    public mutating func append(_ input:String,range:NSRange){
        
        let index = self.characters.index(self.startIndex, offsetBy: range.location)
        self = self.substring(to: index) + input + self.substring(from: index)
    }
    
    public func replaceOf(_ patternString:String, with:String)->String{
        
        return self.replacingOccurrences(of: patternString, with: with)
    }
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        
        let start = characters.index(startIndex, offsetBy: r.lowerBound)
        let end = characters.index(start, offsetBy: r.upperBound - r.lowerBound)

        return String(self[Range(start ..< end)])
     }
    
    //private method
    private func formatToDate()->Date?{
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        dateformatter.timeZone = NSTimeZone.local
        
        return dateformatter.date(from: self)
    }

}
