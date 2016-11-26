//
//  FileIOManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public typealias JSON = AnyObject
public typealias JSONDictionary = Dictionary<String,AnyObject>
public typealias JSONArray = Array<JSON>

public class FileIOHelper{
    
    public static func read(fileName:String, ofType: String)->JSONArray?{
        
        guard fileName.isEmpty && ofType.isEmpty else {
        
            var retval:JSONArray?
            var data:Data?
            var jsonObject:JSON
            
            do{
                if let path = Bundle.main.path(forResource: fileName, ofType: ofType){
                    
                    data = try Data(contentsOf: URL(fileURLWithPath: path))
                    
                    jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as JSON
                    retval = jsonObject as? JSONArray
                }
            }catch {
                retval = JSONArray()
            }

            return retval
        }
        
        return nil
    }
    
    static func writeFileData(fileName:String, ofType: String){
        
    }
    
    
    static func copyFileData(fileName:String, ofType: String){
        
    }
    
    static func backupFileData(fileName:String, ofType: String){
        
    }
}
