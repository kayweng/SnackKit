//
//  FileIOManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias JSONDictionary = Dictionary<String,AnyObject>
public typealias JSONArray = Array<JSON>

public class FileIOHelper{
    
    public static func readJSONFile(name fileName:String,type: String)->JSON?{
        
        var retval:JSON?
        var data:Data?
        
        guard (!fileName.isEmpty || !type.isEmpty) else{
            return retval
        }
        
        do{
            if let path = Bundle.main.path(forResource: fileName, ofType: type){
                
                data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                retval = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? JSON
            }
        }catch {
           
        }
        
        return retval
    }
}
