//
//  AzkarElSabahVC.swift
//  pray times
//
//  Created by Omar barkat on 19/12/2023.
//

import UIKit
import NVActivityIndicatorView

class AzkarElSabahVC: UIViewController {

    var arrAzkar :[AzkarElSabah] = []
    @IBOutlet weak var lblNameAzkar: UILabel!
    @IBOutlet weak var loaderIndecatorView: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLineEtched
        tableView.separatorColor = .white
        loaderIndecatorView.startAnimating()
        timesAPI.getAzkarElSabah { response in
            self.lblNameAzkar.text = response.title
            self.arrAzkar.append(contentsOf: response.content!)
            self.tableView.reloadData()
            self.loaderIndecatorView.isHidden = true
            
            
        }
    }
    
//
//    @IBAction func btnCounter(_ sender: Any) {
//       
//     
//        
//    }
}
extension AzkarElSabahVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAzkar.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AzkarElSabahCell") as! AzkarElSabahCell
        let azkar = arrAzkar[indexPath.row]
        cell.lblAzkarContent.text = azkar.zekr
        cell.lblAzkarDescription.text = azkar.bless
        cell.btnCount.setTitle("(\(azkar.repeat)) التكرار", for: .normal)
        let borderWidth : CGFloat = 1.0
        let borderColer = UIColor.white.cgColor
        cell.layer.borderWidth = borderWidth
        cell.layer.borderColor = borderColer
        cell.layer.cornerRadius = 15
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
