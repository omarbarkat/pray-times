//
//  GetLocationCoordenates.swift
//  pray times
//
//  Created by Omar barkat on 09/12/2023.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

class LocationManger :NSObject, CLLocationManagerDelegate {
     var locationManger = CLLocationManager()
     var currentLocation : CLLocation?
    override init() {
        super.init()
        self.locationManger.delegate = self
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty , currentLocation == nil {
            currentLocation = locations.first
            locationManger.stopUpdatingLocation()
            
            getDeviceCoordinates { lat, long in
                print(lat , long)
                self.userlocation(location: self.currentLocation!)
            }
        }
        
    }
    func getDeviceCoordinates(completionHandler: @escaping (_ latitudeCoor:Double, _ longitudeCoor:Double) -> () ) {
        guard let currentLocation = locationManger.location else {return}
        let latitudeCoor = currentLocation.coordinate.latitude
        let longitudeCoor = currentLocation.coordinate.longitude
        completionHandler(latitudeCoor,longitudeCoor)
    }
    func userlocation (location : CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
              
    }
   
    }
 
