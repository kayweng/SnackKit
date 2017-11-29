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
import Contacts

public typealias GeoLocation = (latitude:CLLocationDegrees, longitude:CLLocationDegrees, name:String?)

public class LocationManager: NSObject, CLLocationManagerDelegate{
    
    public let locationManager = CLLocationManager()
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
        super.init()
        
        self.currentLocation = nil
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
    }
    
    internal func startUpdating(){
        self.locationManager.startUpdatingLocation()
    }
    
    internal func stopUpdating(){
        self.locationManager.stopUpdatingLocation()
    }
    
    public func GetCurrentLocation(completion:((_ location:CNPostalAddress?)->Void)?){
        
        let coder = CLGeocoder()
        
        if CLLocationManager.locationServicesEnabled() && self.GetLocationAuthorizationStatus(prompt:true).0{
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.startUpdating()
            
            coder.reverseGeocodeLocation(locationManager.location!, completionHandler: { (placemarks, error) in
                
                self.stopUpdating()
                
                if let _ = error {
                    print("Error getting location:\(String(describing: error))")
                }else{
                    let placeArray = placemarks as [CLPlacemark]!
                    var placeMark: CLPlacemark!
                    placeMark = placeArray?[0]
                    
                    completion!(placeMark.postalAddress)
                }
            })
        }
    }
    
    public func GetLocationAuthorizationStatus(prompt:Bool)->(status:Bool,description:String){
        
        if !CLLocationManager.locationServicesEnabled(){
            return (false,"Location Service is disabled")
        }
        
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined:
            
            if prompt{
                self.locationManager.requestAlwaysAuthorization()
            }
            
            return (false,"Location Access is not determined")
        case .restricted:
            return (false,"Location Access Restricted")
        case .denied:
            return (false,"Location Access Denied")
        case .authorizedAlways:
            return (true,"Location Access is always using in the app & background")
        case .authorizedWhenInUse:
            return (true,"Location Access is using while in the app")
        }
    }
    
    // MARK: - Delegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations.last!

        self.currentLocation = (userLocation.coordinate.longitude,userLocation.coordinate.latitude,"")
        
        if let callback = self.accessorCallBack, let _ = self.currentLocation{
            callback(self.currentLocation!)
            self.stopUpdating()
        }
    }
    
}
