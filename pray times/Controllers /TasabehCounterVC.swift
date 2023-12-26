//
//  TasabehCounterVC.swift
//  pray times
//
//  Created by Omar barkat on 14/12/2023.
//

import UIKit
import AVFoundation
class TasabehCounterVC: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var restAudioPlayer = AVAudioPlayer()
    var count : Int = 0
    var counter : Int = 0
    var countt : Int = 0
    @IBOutlet weak var lblTotalCounting: UILabel!
    @IBOutlet weak var lblCounter: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let music = Bundle.main.path(forResource: "Music", ofType: "mp3")
        let rest = Bundle.main.path(forResource: "Rest", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
            restAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rest!))

        } catch let error {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnCount(_ sender: Any) {
        audioPlayer.play()
        count = count + 1
        counter = counter + 1
         countt = counter
        GetCount(count: count, countt: countt)
        
    }
    
    @IBAction func btnRestCount(_ sender: Any) {
        restAudioPlayer.play()
        counter = 0
        
        self.lblCounter.text = "\(0)"
        
    }
    
    func GetCount(count : Int , countt : Int ) {
        self.lblCounter.text = "\(countt)"
        self.lblTotalCounting.text = "مجموع التسبيحات : \(count)"
    }
    
    
    
    

}
