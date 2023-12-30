//
//  SurahsCell.swift
//  pray times
//
//  Created by Omar barkat on 12/12/2023.
//

import UIKit

class SurahsCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: ShadowView! {
        didSet {
            shadowView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var lblSurahsNumbers: UILabel!
    @IBOutlet weak var lblSuraName: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
}
