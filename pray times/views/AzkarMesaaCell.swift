//
//  AzkarMesaaCell.swift
//  pray times
//
//  Created by Omar barkat on 19/12/2023.
//

import UIKit

class AzkarMesaaCell: UITableViewCell {

    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var lblAzkarDescription: UILabel!
    @IBOutlet weak var lblAzkarContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCounter(_ sender: Any) {
    }
}
