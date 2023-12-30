//
//  HomeAppVC.swift
//  pray times
//
//  Created by Omar barkat on 22/12/2023.
//

import UIKit

class HomeAppVC: UIViewController {
    let arrAzkar = ["سُبْحَانَ اللَّهِ" , "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ" , "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ" , "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ", "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ ", "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ ", "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد ", "أستغفر الله ", "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَرُ ", "لَا إِلَهَ إِلَّا اللَّهُ ", "الْلَّهُ أَكْبَرُ ", "الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ. ", "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً. ", "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ. ", "اللهم اكفنى بحلالك عن حرامك وأغننى بفضلك عمن سواك ", "سبحان الله الذي يسبح الرعد بحمده والملائكة من خيفته ", "أعوذ بكلمات الله التامات من شر ما خلق ", "رب اغفر لي رب اغفر لي اللهم اغفر لي ، وارحمني واهدني واجبرني وعافني وارزقني وارفعني ", "اللهم لاسهل إلا ماجعلته سهلا وأنت تجعل الحزن إذا شئت سهلا "]
    var arrAsmaa : [AsmaaHosnaData] = []
    var number : Int = 1
    var tasabeehConter : Int = 0
    //MARK: OUTLETS
    @IBOutlet weak var prayerTimesView: UIView! {
        didSet {
            prayerTimesView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var QiblaView: UIView!{
        didSet {
            QiblaView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var AzkarSabahView: UIView!{
        didSet {
            AzkarSabahView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var azkarMasaaView: UIView!{
        didSet {
            azkarMasaaView.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var tasabeihView: UIView! {
        didSet {
            tasabeihView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var nameOfGodView: UIView! {
        didSet {
            nameOfGodView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var btnTasabeehCounter: UIButton!
    @IBOutlet weak var lblTasabeeh: UILabel!
    @IBOutlet weak var lblAsmaHosnaName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Asmaa(number: "\(number)")


        Tasabeh(tasabeehConter: tasabeehConter)
    }
    
    @IBAction func btnTasabeehCounter(_ sender: Any) {
        if tasabeehConter == 18 {
             tasabeehConter = 0
//            tasabeehConter = tasabeehConter - 1
            Tasabeh(tasabeehConter: tasabeehConter)
        } else {
            tasabeehConter = tasabeehConter + 1
            Tasabeh(tasabeehConter: tasabeehConter)
        }
        
    }
    
    @IBAction func btnCounter(_ sender: Any) {
        number = number + 1
         Asmaa(number: "\(number)")
    }
    func Asmaa(number : String ) {
        timesAPI.getAsmaaAlaahElhosna(numbers: "\(number)") { response in
            print(response)
            self.arrAsmaa.append(contentsOf: response)
            print(response[0])
            let name = response[0]
            self.lblAsmaHosnaName.text = name.name
        }
    }
    func Tasabeh(tasabeehConter : Int) {
       
        self.lblTasabeeh.text = arrAzkar[tasabeehConter]
    }
    
}
