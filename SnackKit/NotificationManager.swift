//
//  NotificationManager.swift
//  SnackKit
//
//  Created by kay weng on 19/11/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation
import NotificationCenter
import UserNotifications
import CoreLocation

public typealias NotificationContent = (Key:String,
    title:String,
    subtitle:String?,
    body:String,
    launchImage:String?,
    badgeNumber:Int?,
    repeat:Bool?,
    category:UNNotificationCategory?,
    hasAction:Bool?)

private let center = UNUserNotificationCenter.current()

public class NotificationManager{
    
    public class var shared: NotificationManager {
        
        struct Static {
            static var instance: NotificationManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = NotificationManager()
        }
        
        return Static.instance!
    }
    
    init() {
        
    }
    
    @available(iOS 10, *)
    public func registerUserPushNotification()->Bool?{
        
        var accessPermission:Bool?
        
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if error == nil{
                accessPermission = nil
                print("Notification - Authroization Error")
            }
            
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
                accessPermission = true
                print("Notification - Authroization Granted")
            }else{
                accessPermission = false
                print("Notification - Authroization Denied")
            }
        })
        
        return accessPermission
    }
    

    @available(iOS 10,*)
    public static func sendNotifcation(content:NotificationContent, atRegion region:CLRegion){
        
        if UIApplication.shared.isRegisteredForRemoteNotifications{
            return
        }
        
        let mContent:UNMutableNotificationContent = self.constructContent(content)
        let trigger = UNLocationNotificationTrigger(region:region, repeats: content.repeat ?? false)
        let request = UNNotificationRequest.init(identifier: "Location Notification", content: mContent, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: { (Error) in
            
        })
    }
    
    @available(iOS 10,*)
    public static func sendNotifcation(content:NotificationContent, afterMinutes minutes:Int){
        
        if UIApplication.shared.isRegisteredForRemoteNotifications{
            return
        }
        
        let content:UNMutableNotificationContent = self.constructContent(content)
        let date = Date(timeIntervalSinceNow: TimeInterval(minutes))
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest.init(identifier: "Time Interval Notification", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: { (Error) in
            
        })
    }
    
    @available(iOS 10, *)
    public static func cancelNotification(_ key:String){
        
        if UIApplication.shared.isRegisteredForRemoteNotifications{
            return
        }
        
        center.getPendingNotificationRequests(completionHandler: { (requests:[UNNotificationRequest]) in
            
            for req:UNNotificationRequest in requests{
                
                let userInfoCurrent = req.content.userInfo as! [String:AnyObject]
                let uuid = userInfoCurrent["UUID"] as! String
                
                if uuid == key{
                    center.removePendingNotificationRequests(withIdentifiers: [key])
                    break
                }
            }
        })
    }
    
    @available(iOS 10, *)
    public static func cancelAllPendingNotifcations(){
    
        if UIApplication.shared.isRegisteredForRemoteNotifications{
            return
        }
        
        center.removeAllPendingNotificationRequests()
    }
    
    private static func constructContent(_ item:NotificationContent)->UNMutableNotificationContent{
        
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: item.title, arguments: nil)
        content.subtitle = item.subtitle ?? ""
        content.body = NSString.localizedUserNotificationString(forKey: item.body, arguments: nil)
        content.sound = UNNotificationSound.default()
        content.badge = item.badgeNumber as NSNumber?
        content.launchImageName = item.launchImage ?? ""
        content.categoryIdentifier = item.category?.identifier ?? ""
        
        return content
    }
}
