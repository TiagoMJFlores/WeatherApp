//
//  WeatherList.swift
//  WeatherApp
//
//  Created by Tiago Flores on 30/05/2022.
//

import Foundation

struct WeatherList: Codable {
    let dt: Int
    let main: WeatherLevels
    let weatherImages: [WeatherImage]
    let visibility: Int
    let pop: Double
    let dtTxt: String
    
    var timeStr: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    enum CodingKeys: String, CodingKey {
        case dt, main,  visibility, pop
        case weatherImages = "weather"
        case dtTxt = "dt_txt"
    }
}
