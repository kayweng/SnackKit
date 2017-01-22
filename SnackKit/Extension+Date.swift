//
//  Extension+Date.swift
//  SnackExtension
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

private let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
private let flags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]

// MARK: - NSDate
extension Date
{
    // MARK: - Properties
    public var now:Date{
        
        var nowComponents = DateComponents()
        let date = Date()
        let df = DateFormatter()
        
        df.dateFormat = "yyyy-MM-dd h:mm:ss a"
        df.timeZone = gmtTimeZone

        nowComponents.year = (calendar as NSCalendar).component(NSCalendar.Unit.year, from: date)
        nowComponents.month = (calendar as NSCalendar).component(NSCalendar.Unit.month, from: date)
        nowComponents.day = (calendar as NSCalendar).component(NSCalendar.Unit.day, from: date)
        nowComponents.hour = (calendar as NSCalendar).component(NSCalendar.Unit.hour, from: date)
        nowComponents.minute = (calendar as NSCalendar).component(NSCalendar.Unit.minute, from: date)
        nowComponents.second = (calendar as NSCalendar).component(NSCalendar.Unit.second, from: date)
        
        (nowComponents as NSDateComponents).timeZone = gmtTimeZone
        
        return calendar.date(from: nowComponents)!
    }
    
    public var today:Date{
        
        var nowComponents = DateComponents()
        let date = Date()
        let df = DateFormatter()
        
        df.dateFormat = "MM/dd/yyyy"
        df.timeZone = gmtTimeZone
        
        nowComponents.year = (calendar as NSCalendar).component(NSCalendar.Unit.year, from: date)
        nowComponents.month = (calendar as NSCalendar).component(NSCalendar.Unit.month, from: date)
        nowComponents.day = (calendar as NSCalendar).component(NSCalendar.Unit.day, from: date)
       
        (nowComponents as NSDateComponents).timeZone = gmtTimeZone
        
        return calendar.date(from: nowComponents)!
    }
    
    public var defaultDate:Date{
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd h:mm:ss a"
        df.timeZone = gmtTimeZone
        
        return df.date(from: "01/01/1990")!
    }
    
    public var toString:String{
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = "dd MMM yyyy hh:mm ss a"
        dateformatter.timeZone = gmtTimeZone
        
        return dateformatter.string(from: self)
    }
    
    public var dayName:String{

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        
        return dateformatter.string(from: self)
    }
    
    // MARK: - Methods
    public func add(years:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.year, value: years, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func add(months:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.month, value: months, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func add(days:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: days, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func add(hours:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.hour, value: hours, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func add(minutes:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.minute, value: minutes, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func add(seconds:Int)->Date{
        
        return (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: seconds, to: self, options: NSCalendar.Options.wrapComponents)!
    }
    
    public func greaterThan(_ dateToCompare : Date) ->Bool
    {
        return self.compare(dateToCompare) == ComparisonResult.orderedDescending
    }
    
    
    public func lessThan(_ dateToCompare : Date) ->Bool
    {
        return self.compare(dateToCompare) == ComparisonResult.orderedAscending
    }
    
    
    public func equal(_ dateToCompare : Date) ->Bool
    {
        return self.compare(dateToCompare) == ComparisonResult.orderedSame
    }
    
    public func differInMinutes(_ dateToCompare:Date)->Int{
        
        let elapsed = self.timeIntervalSince(dateToCompare)
        
        return Int(elapsed)
    }
    
    public func toISODate()->Date{
        
        let dateformatter:DateFormatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy"
        dateformatter.timeZone = gmtTimeZone
        
        return dateformatter.date(from: dateformatter.string(from: self))!
    }

    public func era()->Int{
        return (calendar as NSCalendar).components(flags, from: self).era!
    }
    
    public func quarter()->Int{
        return (calendar as NSCalendar).components(flags, from: self).quarter!
    }
    
    public func year()->Int{
        return (calendar as NSCalendar).components(flags, from: self).year!
    }
    
    public func month()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).month
    }
    
    public func day()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).day
    }
    
    public func hour()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).hour
    }
    
    public func minute()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).minute
    }
    
    public func second()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).second
    }
    
    public func nanoSecond()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).nanosecond
    }
    
    public func isValid()->Bool{
        return (calendar as NSCalendar).components(flags, from: self).isValidDate
    }
    
    public func isLeapMonth()->Bool?{
        return (calendar as NSCalendar).components(flags, from: self).isLeapMonth
    }
    
    public func weekday()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).weekday
    }
    
    public func weekOfMonth()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).weekOfMonth
    }
    
    public func weekOfYear()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).weekOfYear
    }
    
    public func yearForWeekOfYear()->Int?{
        return (calendar as NSCalendar).components(flags, from: self).yearForWeekOfYear
    }
    
    public func toText(ti:TimeInterval) ->String{
        
        var retval:String = ""
        var retSecond:Int!
        var retMinute:Int!
        var retHour:Int!
        var retDay:Int!
        
        let second = 1
        let minutes = second * 60
        let hours = minutes * 60
        let days = hours * 24
        
        var ti = Int(abs(ti))
        
        if(ti >= days){
            retDay = ti / days
            ti = ti - (retDay * days)
            
            if retDay == 1{
                retval = String(retDay) + " day "
            }else{
                retval = String(retDay) + " days "
            }
        }
        
        if(ti >= hours){
            retHour = ti / hours
            ti = ti - (retHour * hours)
            
            if retHour == 1{
                retval += String(retHour) + " hour "
            }else{
                retval += String(retHour) + " hours "
            }
        }
        
        if(ti >= minutes){
            retMinute = ti / minutes
            ti = ti - (retMinute * minutes)
            
            if retMinute == 1{
                retval += String(retMinute) + " minute "
            }else{
                retval += String(retMinute) + " minutes "
            }
        }
        
        if(ti >= second){
            retSecond = ti / minutes
            ti = ti - (retSecond * second)
            
            if retSecond == 1{
                retval += String(retSecond) + " second"
            }else{
                retval += String(retSecond) + " seconds"
            }
        }
        
        return retval
    }
}
