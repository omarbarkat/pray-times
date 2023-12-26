//
//  NotivicationVC.swift
//  pray times
//
//  Created by Omar barkat on 02/12/2023.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var datePickerView: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()



    }
    

    
    @IBAction func btnNotification(_ sender: Any) {
        
        
//        let date = Date()
//        let dateForm = DateFormatter()
//        dateForm.dateFormat = "dd LLL yyyy hh mm"
//        let result = dateForm.string(from: date)
//        print(result)
        
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .sound , .badge ]) { confermed, error in
            if confermed {
                print("ok")
                DispatchQueue.main.async {
                    self.schedualNotification()
                }
                
            }else {
                print("error")
            }
        }
    }
    func schedualNotification () {
        let content = UNMutableNotificationContent()
        content.title = "elazaan"
        content.body = "pray Time now "
        content.badge = 1
        //content.sound = .default
        content.userInfo = ["name":"omar barkat"]
        content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "a1.wav"))

//        if let soundURL = Bundle.main.url(forResource: "a1", withExtension: "wav") {
//            content.sound = UNNotificationSound.init(named: .init(rawValue: soundURL.absoluteString))
//        }
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
        
//        var componant = DateComponents()
//        componant.calendar = Calendar.current
//        componant.weekday = 7
//        componant.hour = 18
//        componant.minute = 10
//        let trigger = UNCalendarNotificationTrigger(dateMatching: componant, repeats: false)
        let date = datePickerView.date
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year ,.month , .day , .hour ,.minute ,.second], from: date), repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "testID", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
func timeString (dateString : String) {
    let currentTime = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: currentTime)
    let currentMonth = calendar.component(.month, from: currentTime)
    let currentDay = calendar.component(.day, from: currentTime)
    let apiTimeString = "\(currentYear)" + " " + "\(currentMonth)" + " " + "\(currentDay)" + " " + "\(dateString)"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy MM dd HH:mm (zzz)"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let apiDate = dateFormatter.date(from: apiTimeString)
    print(apiDate)
}

