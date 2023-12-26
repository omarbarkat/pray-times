//
//  ViewController.swift
//  pray times
//
//  Created by Omar barkat on 26/11/2023.
//

import UIKit
import UserNotifications
import CoreLocation
import MapKit
import Foundation
import NVActivityIndicatorView

class ViewController: UIViewController , CLLocationManagerDelegate {
   
    var remainingTime: String = ""
    let prayerTimes: [String] = []
    var timer: Timer?
    var remainingTimeSeconds:Int = 300
 //   var remainingTime = 0.0
    //MARK: OUTLETS
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var lblCountdownTime: UILabel!
    @IBOutlet weak var lblIsha: UILabel!
    @IBOutlet weak var lblMaghrib: UILabel!
    @IBOutlet weak var lblAsr: UILabel!
    @IBOutlet weak var lblduhr: UILabel!
    @IBOutlet weak var lblSunrise: UILabel!
    @IBOutlet weak var lblFajr: UILabel!
    var locationManger = CLLocationManager()
    var currentLocation:CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
//        loaderView.startAnimating()

//        updateCountdown()
        
        
        // logic for use location service
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.allowsBackgroundLocationUpdates = true
        requestWeatherForLocation()
        if isLocationEnabled() {
            checkAuthorization()
        }else {
           alert(msg: "Please Enable Location Service")
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
    
    @IBAction func btnDiesmiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)

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
            requestWeatherForLocation()
            userlocation(location: currentLocation!)
        }
    }
    func requestWeatherForLocation() {
           guard let currentLocation = currentLocation else {
               return
           }
        //MARK: LOGIC GET CURRENT DATE
        let date = Date()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd LLL yyyy"
        let result = dateForm.string(from: date)
        print(result)
        let dateFormYear = DateFormatter()
        dateFormYear.dateFormat = "yyyy"
        let resultYear = dateFormYear.string(from: date)
        let dateFormMonth = DateFormatter()
        dateFormMonth.dateFormat = "MM"
        print(resultYear)
        let resultMonth = dateFormMonth.string(from: date)
        print(resultMonth)
        
           var long = "\(currentLocation.coordinate.longitude)"
           var lat = "\(currentLocation.coordinate.latitude)"
        print(long)
        print(lat)
        timesAPI.getTimesByCordinats(latitude: lat, longitude: long, month: resultMonth, year: resultYear, method: "\(5)") { fajr,sunRise,dhure,asr,maghrib,isha,notificationBody   in
                        self.lblFajr.text = fajr
                        self.lblSunrise.text = sunRise
                        self.lblduhr.text = dhure
                        self.lblAsr.text = asr
                        self.lblMaghrib.text = maghrib
                        self.lblIsha.text = isha
            self.times(prayTime: fajr, notificationBody: "حان الان موعد اذان الفجر")
            self.times(prayTime: dhure, notificationBody: "حان الان موعد اذان الظهر")
            self.times(prayTime: asr, notificationBody: " حان الان موعد اذان العصر")
            self.times(prayTime: maghrib, notificationBody: " حان الان موعد اذان المغرب")
            self.times(prayTime: isha, notificationBody: "حان الان موعد اذان العشاء")
            self.remainingTimeForNextPrayer(prayerTimes: [fajr , dhure , asr , maghrib , isha])
            let remainingTime = self.remainingTimeForNextPrayer(prayerTimes: [fajr , dhure , asr , maghrib , isha])
            print(remainingTime)
            let componants = remainingTime.components(separatedBy: ":")
            print("0 \(componants[0]) , 1 \(componants[1])")
            let trimmedHours = componants[0].trimmingCharacters(in: .whitespaces)
            let trimmedMinutes = componants[1].trimmingCharacters(in: .whitespaces)

            if componants.count == 2 , let hours = Int(trimmedHours) , let minutes = Int(trimmedMinutes) {
                let remainingTime = hours * 60 + minutes
                self.startCountdown(remainingTimeSeconds: remainingTime)
                print(self.startCountdown(remainingTimeSeconds: remainingTime))
            }else {
                print("error in convert to int")

            }
           
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
    //MARK: ACTIONS
    func times(prayTime:String , notificationBody:String) {
        let currentTime = Date()
        let calendar2 = Calendar.current
        let currentYear = calendar2.component(.year, from: currentTime)
        let currentMonth = calendar2.component(.month, from: currentTime)
        let currentDay = calendar2.component(.day, from: currentTime)

        let apiTimeString = "\(currentYear)" + " " + "\(currentMonth)" + " " + "\(currentDay)" + " " + "\(prayTime)"
        print(apiTimeString)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy MM dd HH:mm (zzz)"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
         if let apiDate = dateFormatter.date(from: apiTimeString) {
            let currentTime = Date()
            let calendar2 = Calendar.current
            let currentYear = calendar2.component(.year , from: currentTime)
            print(currentYear)
             var remainingTime = "\((apiDate.timeIntervalSince(currentTime) / 60 / 60 ))"
            
            print(apiDate)
            let calendar = Calendar.current
            //the logic of component from  api date
            let components = Calendar.current.dateComponents([.hour, .minute], from: apiDate)
            // the logic to set notifi times
            var dateComponents = DateComponents()
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute
            let currentDate = Date()
            let currentComponants = Calendar.current.dateComponents([.year , .month , .day], from: currentDate)
            dateComponents.year = currentComponants.year
            dateComponents.month = currentComponants.month
            dateComponents.day = currentComponants.day
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            //logic to notifi content
            let content = UNMutableNotificationContent()
            content.title = "El Azaan"
            content.body = notificationBody
            //content.sound = UNNotificationSound.default
            content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "a1.wav"))
            //logic request notifi
            let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("فشل في إعداد الإشعار: \(error.localizedDescription)")
                } else {
                    let customDateFormatter = DateFormatter()
                    customDateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss Z"
                    customDateFormatter.timeZone = TimeZone(identifier: "PST")
                    
                    let formattedApiDate = customDateFormatter.string(from: apiDate)
                    print("تم إعداد الإشعار بنجاح. \(formattedApiDate)")
                }
            }
        }
        
        loaderView.isHidden = true

    }
    
   
    func remainingTimeForNextPrayer (prayerTimes : [String]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm (zzz)"
        dateFormatter.timeZone = TimeZone.current
        let currentDate = Date()
        let currentTimeString = dateFormatter.string(from: currentDate)
//        print(currentTimeString)
//        let currentDateFormate = DateFormatter()
//        currentDateFormate.dateFormat = "yyyy-MM-dd HH:mm (zzz)"
//        print(currentDateFormate)
//        let currentTimeFormateString = dateFormatter.string(from: currentDate)

        
        guard let currentTime = dateFormatter.date(from: currentTimeString) else {return "error in formating"}
        var remainingTimes : [TimeInterval] = []
        for prayerTime in prayerTimes {
            guard let prayerDate = dateFormatter.date(from: prayerTime) else {return "error in formating"}
                let timeDifferance = (prayerDate.timeIntervalSince(currentTime))
                remainingTimes.append(timeDifferance)
        }
        guard let minRemainingTime = remainingTimes.min() , let index = remainingTimes.firstIndex(of: minRemainingTime) else {return "error format"
        }
        
        let nextPrayerTime = prayerTimes[index]
        print(nextPrayerTime)
        let hours = Int(minRemainingTime * 60 / 3600)
        print(hours)
        let minutes = Int((minRemainingTime.truncatingRemainder(dividingBy: 3600)) / 60)
        print(minutes)
        let remainingTime = Int(minRemainingTime / 60)
        
        return "\(hours):\(minutes)"
        print("\(hours):\(minutes)")
        let prayerTimes = prayerTimes
        let result = remainingTimeForNextPrayer(prayerTimes: prayerTimes)
//        let result = remainingTimeForNextPrayer(prayerTimes: prayerTimes)
        print(result)
      
        
                
    }
    func startCountdown(remainingTimeSeconds : Int) {
        self.remainingTime = "\(remainingTimeSeconds)"
        print(self.remainingTimeSeconds = remainingTimeSeconds)
        print(remainingTimeSeconds)
        updateCountDownLabl()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown(){
        guard remainingTimeSeconds > 0 else {timer?.invalidate()
            return
        }
        remainingTimeSeconds -= 1
        updateCountDownLabl()
    }
    func updateCountDownLabl() {
        let hours = remainingTimeSeconds / 3600
//        print(hours)
        let minutes = remainingTimeSeconds % 3600 / 60
//        print(minutes)
        let seconds = remainingTimeSeconds % 60
//        print(seconds)

        self.lblCountdownTime.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

    

