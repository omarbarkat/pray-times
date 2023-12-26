//
//  azkar.swift
//  pray times
//
//  Created by Omar barkat on 15/12/2023.
//

import UIKit
import UserNotifications

class AzkarVC: UIViewController {
    
    let arrAzkar = ["سُبْحَانَ اللَّهِ" , "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ" , "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ" , "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ", "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ ", "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ ", "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد ", "أستغفر الله ", "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ ", "لَا إِلَهَ إِلَّا اللَّهُ ", "الْلَّهُ أَكْبَرُ ", "الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ. ", "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً. ", "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ. ", "اللهم اكفنى بحلالك عن حرامك وأغننى بفضلك عمن سواك ", "سبحان الله الذي يسبح الرعد بحمده والملائكة من خيفته ", "أعوذ بكلمات الله التامات من شر ما خلق ", "رب اغفر لي رب اغفر لي اللهم اغفر لي ، وارحمني واهدني واجبرني وعافني وارزقني وارفعني ", "اللهم لاسهل إلا ماجعلته سهلا وأنت تجعل الحزن إذا شئت سهلا "]
    var previouseAzkar : String?
    override func viewDidLoad() {
        super.viewDidLoad()

    
        notifocationSchedual()
//        notifocationSchedual(title: "سُبْحَانَ اللَّهِ , سُبْحَانَ اللَّهِ وَبِحَمْدِهِ , سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ"  , timeInterval: 120)


    }
    

    
    
    
    func notifocationSchedual() {
        
        var filteredAzkar = arrAzkar
        if let previouseAzkar = previouseAzkar , let index = filteredAzkar.firstIndex(of: previouseAzkar) {
            filteredAzkar.remove(at: index)
        }
        guard let randamAzkar = filteredAzkar.randomElement() else {return}
        previouseAzkar = randamAzkar
        
        let content = UNMutableNotificationContent()
        content.title = "El Azaan"
        content.body = randamAzkar
        content.sound = .default
         
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        let request = UNNotificationRequest(identifier: "azkar", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("error")
            }
        }
    }

}
