//
//  AzkarElSabahCell.swift
//  pray times
//
//  Created by Omar barkat on 19/12/2023.
//

import UIKit

class AzkarElSabahCell: UITableViewCell {

    var count: AzkarElSabah!
    var arrAzkar :[AzkarElSabah] = []
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var lblAzkarDescription: UILabel!
    @IBOutlet weak var lblAzkarContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timesAPI.getAzkarElSabahCounter { response in
            print(response)
            self.arrAzkar.append(contentsOf: response)
            
        }
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCounter(_ sender: Any) {
        if let user = UserAzkar.UserAzkar {
            btnCount.setTitle("Likes \((count?.repeat) ?? 0 - 1)", for: .normal)
        }
    }
    
}
