//
//  QiblaInfo.swift
//  pray times
//
//  Created by Omar barkat on 07/12/2023.
//

import Foundation
import UIKit
// TYPE >>>>>
struct Qibla: Codable {
    let code: Int
    let status: String
    let data: data
}

struct data: Codable {
    let latitude : Float?
    let longitude : Float?
    let direction : Float?
}
 
