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
public typealias Currency = (country:String,code:String,symbol:String, vat: Double)

//@Global const variables
public let appDelegate = UIApplication.shared.delegate
public let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

//@Font
public var minFont:UIFont = UIFont.systemFont(ofSize: CGFloat(9))
public var defaultFont = UIFont.systemFont(ofSize: CGFloat(14))
public var defaultBoldFont = UIFont.boldSystemFont(ofSize: CGFloat(14))
public var defaultItalicFont = UIFont.italicSystemFont(ofSize: CGFloat(14))

//@Version
public let systemVersion = UIDevice.current.systemVersion;

//@Format
public let gmtTimeZone = TimeZone(abbreviation: NSTimeZone.local.abbreviation()!)


//@Global Struct
public struct ScreenSize
{
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

public struct DeviceType
{
    public static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}
