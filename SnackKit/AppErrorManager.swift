//
//  AppErrorHandler.swift
//  SnackKit
//
//  Created by kay weng on 20/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public enum CoreDataError : Error{
    case ReadError
    case SaveError
    case DeleteError
}

public enum AppError : Error{
    case NilReferenceError
    case UnknowError
}

public enum MathError :Error{
    case DivideByZero()
    case InvalidNumeric()
}


public class AppErrorManager{
    
    let errorTitle = "Error"
    
    public class var shared: AppErrorManager {
        
        struct Static {
            static var instance: AppErrorManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = AppErrorManager()
        }
        
        return Static.instance!
    }
    
    init(){
        
    }
    
    public func throwApplicationError(_ error:Error, with message:String){
        
    }
    
}
