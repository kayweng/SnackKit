//
//  ApiHelper.swift
//  SnackKit
//
//  Created by kay weng on 30/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation

public class ApiHelper{
    
    public static func sendApiRequest(at url:String, method:String? = "GET",completion:@escaping (_ json:[String:Any]?)->Void){
    
        var json:[String:Any]?
        let url:URL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) {(data, response, error) in
            
            guard let data = data, let _:URLResponse = response, error == nil else {
                print(error ?? "Function Error !")
                return
            }
            
            json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]

            completion(json)
        }
        
        task.resume()
    }
    
}
