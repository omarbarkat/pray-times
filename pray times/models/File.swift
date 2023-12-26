//
//  File.swift
//  pray times
//
//  Created by Omar barkat on 19/12/2023.
//

import Foundation
import UIKit

struct azkarr : Codable {
    let title : String
    let content : [AzkarElSabah]?
}

struct AzkarElSabah : Codable {

   let zekr: String?
   let `repeat`: Int
   let bless: String?
}


struct azkarMasaa : Codable {
    let title : String
    let content : [AzkarElMasaa]
}

struct AzkarElMasaa : Codable {

    let zekr: String?
    let `repeat`: Int
    let bless: String?
}


