//
//  QiblaDirectionVC.swift
//  pray times
//
//  Created by Omar barkat on 07/12/2023.
//

import UIKit
import CoreLocation
import MapKit

class QiblaDirectionVC: UIViewController ,CLLocationManagerDelegate {
    var locationManger = CLLocationManager()
    var currentLocation:CLLocation?

    var latCoor:Double?
    var longCoor:Double?
    @IBOutlet weak var lblQiblaDirection: UILabel!
    @IBOutlet weak var imgQiblaDirection: UIImageView!
    var qiblaDirection : Float?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.allowsBackgroundLocationUpdates = true
        
        updateQiblaDirection()
//        updateUI()
        
        if isLocationEnabled() {
            checkAuthorization()
//            mapView.isHidden = true
        }else {
            alert(msg: "please Enable Location Sevice")
        }

    }

   
    func isLocationEnabled() ->Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    func checkAuthorization () {
        switch locationManger.authorizationStatus {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse :
            locationManger.startUpdatingLocation()
//            mapView.showsUserLocation = true
            break
        case .authorizedAlways :
//            mapView.showsUserLocation = true
            break
        case .restricted :
            print("default ..")
            break
        case .denied :
            print("default ..")
            
            break
        default:
            print("default ..")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse :
            locationManger.startUpdatingLocation()
//            mapView.showsUserLocation = true
            break
        case .authorizedAlways :
//            mapView.showsUserLocation = true
            break
       
        default:
            print("default ..")
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  !locations.isEmpty , currentLocation == nil{
            currentLocation = locations.first
            locationManger.stopUpdatingLocation()
            userlocation(location: currentLocation!)
            let lat = currentLocation!.coordinate.latitude
            let long = currentLocation!.coordinate.longitude
            updateQiblaDirection()

//            timesAPI.getQiblaDirection(latitude: "\(lat)", longitude: "\(long)") { direction in
//                let direction = direction.data.direction
//                self.qiblaDirection = direction
//            }
        
        }
    }
    func alert (msg:String) {
        let alert = UIAlertController(title: "alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func userlocation (location : CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
              
    }
    
        func updateQiblaDirection() {
            guard let currentLocation = currentLocation else {
                return
            }
            var long = "\(currentLocation.coordinate.longitude)"
            var lat = "\(currentLocation.coordinate.latitude)"
            timesAPI.getQiblaDirection(latitude: lat, longitude: long) { direction in
                print(direction.data.direction)
                let direction = direction.data.direction
                self.qiblaDirection = direction
                self.updateUI(direction: direction)
            }
        }
      
    
    
    func updateUI(direction : Float?) {
        // تحديث زاوية البصلة وعرضها
        if let qiblaDirection = direction {
            let rotationAngle = CGFloat(qiblaDirection).toRadians()
            imgQiblaDirection.transform = CGAffineTransform(rotationAngle: rotationAngle)
            lblQiblaDirection.text = String(format: "%.2f°", qiblaDirection)
        } else {
            lblQiblaDirection.text = "غير متاح"
        }
    }
    
}
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180.0
    }
}
