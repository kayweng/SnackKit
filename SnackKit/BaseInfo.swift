//
//  Variables.swift
//  SnackBase
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

//@Global Alias
public typealias ManagedObjectResult = Dictionary<String, AnyObject>
public typealias DictionaryResult = [String : AnyObject]

//@Global const variables
public let appDelegate = UIApplication.shared.delegate
public let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
public let systemVersion = UIDevice.current.systemVersion;

//@TimeZone
public let gmtTimeZone = TimeZone(abbreviation: NSTimeZone.local.abbreviation()!)
public let utcTimeZone = TimeZone(abbreviation: NSTimeZone.default.abbreviation()!)

//@Locale
public struct AppLocale
{
    public static let countryCode = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
    public static let countryName = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
    public static let currency = (Locale.current as NSLocale).object(forKey: NSLocale.Key.currencyCode)  as! String
    public static let symbol = (Locale.current as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as! String
}

public struct AppRegion
{
    public static let isMetric = (Locale.current as NSLocale).object(forKey: NSLocale.Key.usesMetricSystem) as! Bool
    public static let temperateUnit = (Locale.current as NSLocale).object(forKey: NSLocale.Key.temperatureUnit) as! String
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
}

//@Device Type
public struct DeviceType
{
    public static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}
