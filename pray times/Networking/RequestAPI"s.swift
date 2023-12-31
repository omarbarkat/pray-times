//
//  RequestAPI"s.swift
//  pray times
//
//  Created by Omar barkat on 26/11/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class timesAPI {
    
    
    static func getAzkarElMasaa(completionHandler : @escaping (azkarMasaa) -> () ) {
        let url = "https://ahegazy.github.io/muslimKit/json/azkar_massa.json"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let azkar = try decodable.decode(azkarMasaa.self, from: jsonData.rawData())
//
                print(azkar)
                completionHandler(azkar)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    static func getAzkarElSabah(completionHandler : @escaping (azkarr) -> () ) {
        let url = "https://ahegazy.github.io/muslimKit/json/azkar_sabah.json"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let azkar = try decodable.decode(azkarr.self, from: jsonData.rawData())
//
                print(azkar)
                completionHandler(azkar)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    
    
    static func getAzkarElSabahCounter(completionHandler : @escaping ([AzkarElSabah]) -> () ) {
        let url = "https://ahegazy.github.io/muslimKit/json/azkar_sabah.json"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            let content = jsonData["content"] 
            print(content)
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let azkar = try decodable.decode([AzkarElSabah].self, from: content.rawData())
//
                print(azkar)
                
                completionHandler(azkar)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    static func getAsmaaAlaahElhosna(numbers:String , completionHandler : @escaping ([AsmaaHosnaData]) -> () ) {
        let url = "http://api.aladhan.com/v1/asmaAlHusna/\(numbers)"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            let data = jsonData["data"]
            let ayahss = data["ayahs"]
            print(data)
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let asmaa = try decodable.decode([AsmaaHosnaData].self, from: data.rawData())
                print(asmaa)
                completionHandler(asmaa)
            } catch let error {
                print(error)
            }
        }
    }
    
    static func getAllSurahs( completionHandler : @escaping ([dataa]) -> () ) {
        let url = "http://api.alquran.cloud/v1/surah"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            let data = jsonData["data"]
            let ayahss = data["ayahs"]
            print(data)
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let quran = try decodable.decode([dataa].self, from: data.rawData())
//                let ayah = try decodable.decode([ayahs].self, from: ayahss.rawData())
//                print(ayah)
                print(quran)
                completionHandler(quran)
            } catch let error {
                print(error)
            }
        }
    }
    
    static func getQuraanBySurah(number : Int ,  offset:Int ,limit:Int , completionHandler : @escaping ([ayahs],quraan) -> () ) {
        let url = "http://api.alquran.cloud/v1/surah/\(number)"
        AF.request(url).responseJSON { response in
            print(response.value)
            let jsonData = JSON(response.value)
            print(jsonData)
            let data = jsonData["data"]
            let ayahss = data["ayahs"]
            
            let dataa = JSON(data)
            print(data)
          
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let quran = try decodable.decode(quraan.self, from: jsonData.rawData())
                let ayah = try decodable.decode([ayahs].self, from: ayahss.rawData())
                completionHandler(ayah,quran)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    static func getQiblaDirection(latitude:String ,longitude:String , CompletionHandler : @escaping (Qibla) ->()  ) {
        let url = "http://api.aladhan.com/v1/qibla/:latitude/:longitude"
        let params = [
            latitude : latitude ,
            longitude : longitude
        ]
        AF.request(url, method: .get, parameters: params, encoder:URLEncodedFormParameterEncoder.default).responseJSON { response in
            let jsonData = JSON(response.value)
            print(jsonData)
            let data = jsonData["data"]
            let dataa = JSON(data)
            print(data)
          
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let direction = try decodable.decode(Qibla.self, from: jsonData.rawData())
                print(direction.data.direction)
                CompletionHandler(direction)
            } catch let error {
                print(error)
            }
        }
    }
    static func getTimesByCordinats(latitude:String ,longitude:String , month:String , year:String ,method:String , CompletionHandler : @escaping ( _ fajr : String,_ Sunrise : String,_ dhuhr : String,_ asr:String,_ Maghrib:String,_ Isha: String , Response) -> () ){
    
        let date = Date()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "dd LLL yyyy"
        let result = dateForm.string(from: date)
        print(result)
        let dateFormYear = DateFormatter()
        dateFormYear.dateFormat = "yyyy"
        let resultYear = dateFormYear.string(from: date)
        let dateFormMonth = DateFormatter()
        dateFormMonth.dateFormat = "MM"
        let resultMonth = dateFormYear.string(from: date)
        print(resultYear)
        print(resultMonth)
        let calendre = NSCalendar.current
        let url = "http://api.aladhan.com/v1/calendar"
        
        let params = [
           "latitude" : latitude,
            "longitude" : longitude,
            "month" : month , 
            "year" : year ,
            "method" : method ,
        ]
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
 //           print(response.value)
            let jsonData = JSON(response.value)
//            print(jsonData)
            let dataa = jsonData["data"]
            let timings = JSON(dataa)
        //    print(timings)
            let times = timings["timings"]
            var currentDate = "02 Nov 2023"
            do {
                let decodable = JSONDecoder()
                decodable.keyDecodingStrategy = .convertFromSnakeCase
                let root = try decodable.decode(Response.self, from: jsonData.rawData())
                print(root.status)
                for item in root.data {
                    print(item.date.readable)
                    if (item.date.readable == result ) {
                        print("SUCCESS YA BARKAT:::\(item)")
                        if let fajr = item.timings?.Fajr , let asr = item.timings?.Asr ,  let sunRise = item.timings?.Sunrise , let duhr = item.timings?.Dhuhr ,let maghrib = item.timings?.Maghrib , let isha = item.timings?.Isha {
                            print(fajr)
                            print(asr)
                            print(sunRise)
                            print(duhr)
                            print(maghrib)
                            print(isha)
                            CompletionHandler(fajr, sunRise, duhr, asr, maghrib, isha, root)
                        }
                    } else {
                        print("SHIT:::")
                    }
                }
            } catch let error{
                print(error)
            }
                }
            }
         
        }



