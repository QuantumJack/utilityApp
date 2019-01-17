//
//  GPSInfo.swift
//  utilityApp
//
//  Created by Weiran Guo on 2018/11/22.
//  Copyright © 2018 the_world. All rights reserved.
//

import Foundation
import CoreLocation

struct GPS {
    static func getlocation(completion: @escaping(_ latitude:Double, _ longitude:Double) -> Void) {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        locManager.requestAlwaysAuthorization()
        var currentLocation: CLLocation!
        
        if !( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            locManager.requestWhenInUseAuthorization()
            //locManager.requestAlwaysAuthorization()
            print("location failed")
            completion(38.5601, -121.7773)
            return
        }
        currentLocation = locManager.location
        if (currentLocation == nil){
            print("gps failure")
            completion(38.5601, -121.7773)
            return
        }
        else{
            completion(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        	return
        }
    }
}
