//
//  LocationManager.swift
//  SnackKit
//
//  Created by kay weng on 07/12/2016.
//  Copyright © 2016 snackcode.org. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public typealias GeoLocation = (latitude:CLLocationDegrees, longitude:CLLocationDegrees, name:String?)

public class LocationManager: NSObject, CLLocationManagerDelegate{
    
    private let locationManager = CLLocationManager()
    private var currentLocation:GeoLocation?
    var accessorCallBack:((_ location:GeoLocation)->Void)?
    
    public class var shared: LocationManager {
        
        struct Static {
            static var instance: LocationManager? = nil
        }
        
        if Static.instance == nil{
            Static.instance = LocationManager()
        }
        
        return Static.instance!
    }
    
    override init() {
        
        self.currentLocation = nil
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    internal func startUpdating(){
        self.locationManager.startUpdatingLocation()
    }
    
    internal func stopUpdating(){
        self.locationManager.stopUpdatingLocation()
    }
    
    public func GetCurrentLocation(completion:((_ location:GeoLocation)->Void)?){
        
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.delegate = self
            self.startUpdating()
        }else{
            print("Location Service Disabled !")
        }
        
        self.accessorCallBack = completion
    }
    
    public func GetNearestCity(completion:((_ location:JSONDictionary)->Void)?){
        
        let coder = CLGeocoder()
        
        if CLLocationManager.locationServicesEnabled(){
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.startUpdating()
            
            coder.reverseGeocodeLocation(locationManager.location!, completionHandler: { (placemarks, error) in
                
                self.stopUpdating()
                
                if let _ = error {
                    print("Error getting location:\(error)")
                }else{
                    let placeArray = placemarks as [CLPlacemark]!
                    var placeMark: CLPlacemark!
                    placeMark = placeArray?[0]
                    
                    completion!(placeMark.addressDictionary as! JSONDictionary)
                }
            })
            
        }else{
            print("Location Service Disabled !")
        }
    }
    
    // MARK : - Delegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations.last!

        self.currentLocation = (userLocation.coordinate.longitude,userLocation.coordinate.latitude,"")
        
        if let callback = self.accessorCallBack, let _ = self.currentLocation{
            callback(self.currentLocation!)
            self.stopUpdating()
        }
    }
}
