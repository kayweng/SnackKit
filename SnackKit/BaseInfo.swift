//
//  Variables.swift
//  SnackBase
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

//@Global Alias
internal typealias ManagedObjectResult = Dictionary<String, AnyObject>
internal typealias DictionaryResult = [String : AnyObject]

//@Global const variables
public let systemVersion = UIDevice.current.systemVersion;

//@TimeZone
public let gmtTimeZone = TimeZone(abbreviation: NSTimeZone.local.abbreviation()!)
public let utcTimeZone = TimeZone(abbreviation: NSTimeZone.default.abbreviation()!)

//@Locale
public struct DeviceLocale
{
    public static var countryCode:String{
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
    }
    
    public static var countryName:String{
        return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)!
    }
    
    public static var currency:String{
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.currencyCode) as! String
    }
    
    public static var symbol:String{
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as! String
    }
}

public struct DeviceRegion
{
    public static var isMetric:String{
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.usesMetricSystem) as! String
    }
    
    public static var temperateUnit:String{
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.temperatureUnit) as! String
    }
}


//@Font
public struct FontSize
{
    public static let MIN = UIFont.systemFont(ofSize: CGFloat(9))
    public static let SYSTEM = UIFont.systemFont(ofSize: CGFloat(14))
    public static let SYSTEM_BOLD = UIFont.boldSystemFont(ofSize: CGFloat(14))
    public static let SYSTEM_ITALIC = UIFont.italicSystemFont(ofSize: CGFloat(14))
}

//@Global Struct
public struct ScreenSize
{
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
    public static func GetScreenWidth(in percentage:Double) -> CGFloat{
        
        return CGFloat(ScreenSize.SCREEN_WIDTH * CGFloat(percentage/100))
    }
}

//@Device Type
public struct DeviceType
{
    public static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_7P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_8P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
}
