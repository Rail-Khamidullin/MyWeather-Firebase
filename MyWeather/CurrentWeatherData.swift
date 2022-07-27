//
//  CurrentWeatherData.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation

//   Структура погоды, которая приходит от сервера
struct CurrrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
//    Если мы хотим изменить имя ключа н/п feels_like, то можем использовать enum
    enum CodingKeys: String, CodingKey {
        case temp
//        таким образом показываем замену со snak case на camal case
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
}
struct Wind: Codable {
    let speed: Double
}
struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

