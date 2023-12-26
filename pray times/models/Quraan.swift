//
//  Quraan.swift
//  pray times
//
//  Created by Omar barkat on 10/12/2023.
//

import Foundation
import UIKit

struct quraan : Codable {
    let code : Int
    let status : String
    let data : dataa
}

struct dataa : Codable {
    let numberOfAyahs : Int
    let name : String
    let englishNameTranslation : String
    let englishName : String
    let revelationType : String
    let ayahs : [ayahs]?
    let number : Int
    
}
struct edition : Codable {
    let language : String
    let name : String
    let type : String
}
struct ayahs : Codable {
    let hizbQuarter : Int
    let text : String
    let page : Int
    let juz : Int
    let sajda : Bool
    let numberInSurah : Int
    let manzil : Int
}
