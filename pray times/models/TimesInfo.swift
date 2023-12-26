//
//  TimesInfo.swift
//  pray times
//
//  Created by Omar barkat on 28/11/2023.
//

import Foundation
import UIKit
// TYPE >>>>>
struct Response: Codable {
    let code: Int
    let status: String
    let data: [Data]
}

struct Data: Codable {
    let timings: Timing?
    let date: PrayDate
    let meta: Meta?
}

struct Timing: Codable {
    let Fajr: String?
    let Sunrise: String?
    let Dhuhr: String?
    let Asr: String?
    let Sunset: String?
    let Maghrib: String?
    let Isha: String?
    let Imsak: String?
    let Midnight: String?
    let Firstthird: String?
    let Lastthird: String?
}

struct PrayDate: Codable {
    let readable: String
}

struct Meta: Codable {
    let latitude: Float?
    let longitude: Float?
}

