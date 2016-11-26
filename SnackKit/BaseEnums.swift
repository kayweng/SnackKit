//
//  Enums.swift
//  SnackBase
//
//  Created by kay weng on 18/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public enum TableAction:String
{
    case Insert = "Insert"
    case Update = "Update"
    case Delete = "Delete"
    case Move   = "Move"
}

public enum AccessMode:String
{
    case New = "NEW"
    case Edit = "EDIT"
    case Delete = "DELETE"
    case View = "VIEW"
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
