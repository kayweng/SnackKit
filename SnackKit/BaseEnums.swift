//
//  SnackBase
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public enum TableAction:String
{
    case Insert
    case Update
    case Delete
    case Move
}

public enum EntityContextError:Error
{
    case NoRecord
    case NullReference
    case InvalidObject
    case CoreDataError
    case SaveError
    case ReadError
}

public enum UIUserInterfaceIdiom : Int
{
    case unspecified
    case phone
    case pad
}

public enum TemperatureUnit:String{
    
    case Celsius = "Celsius"
    case Fahrenheit = "Fahrenheit"
    
    public var symbol:String{
     
        if self == TemperatureUnit.Celsius{
            return "°C"
        }else if self == TemperatureUnit.Fahrenheit{
            return "°F"
        }else{
            return ""
        }
    }
    
    public var metric:String{
        
        if self == TemperatureUnit.Celsius{
            return "C"
        }else if self == TemperatureUnit.Fahrenheit{
            return "F"
        }else{
            return ""
        }
    }
}

public enum PartsOfDay:String{
    
    case Morning = "Morning"
    case Afternoon = "Afternoon"
    case Evening = "Evening"
    case Night = "Night"

}

public enum DayOfWeek:String{
    
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

