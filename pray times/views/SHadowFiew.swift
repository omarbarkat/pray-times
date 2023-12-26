//
//  SHadowFiew.swift
//  pray times
//
//  Created by Omar barkat on 10/12/2023.
//

import Foundation
import UIKit

class ShadowView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
    }
    func setupShadow () {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        
    }
}
