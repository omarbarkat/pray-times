//
//  AsmaHosnaVC.swift
//  pray times
//
//  Created by Omar barkat on 14/12/2023.
//

import UIKit


class AsmaHosnaVC: UIViewController {

    var arrAsmaa : [AsmaaHosnaData] = []
    var number : Int = 1
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblAsmaaName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Asmaa(number: "\(number)")
    }
    

    @IBAction func btnNext(_ sender: Any) {
       number = number + 1
        Asmaa(number: "\(number)")
        
    }
    
    func Asmaa(number : String ) {
        timesAPI.getAsmaaAlaahElhosna(numbers: "\(number)") { response in
            print(response)
            self.arrAsmaa.append(contentsOf: response)
            print(response[0])
            let name = response[0]
            self.lblAsmaaName.text = name.name
        }
    }
    

}
