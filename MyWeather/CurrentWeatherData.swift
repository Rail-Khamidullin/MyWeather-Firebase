//
//  CurrentWeatherData.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation

//   Структура погоды, которая приходит от сервера
struct CurrrentWeatherData: Codable {
    
//    Название города
    let name: String
//    Структура с температурой, давлением, влажностью
    let main: Main
//    Структура с id номером для краткого описания текущей погоды
    let weather: [Weather]
//    Скорость ветра
    let wind: Wind
//    Структура с рассветом и закатом
    let sys: Sys
}

struct Main: Codable {
//    темпертура
    let temp: Double
//    ощущаемая температура
    let feelsLike: Double
//    давление
    let pressure: Int
//    влажность
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

//   ]структура с краткими погодными условиями
struct Weather: Codable {
//    id - цифровое значение, которое имеет краткое описание текущей погоды
    let id: Int
}

//   Структура со скоростью ветра
struct Wind: Codable {
//    скорость ветра
    let speed: Double
}

//   Структура с временем рассвета и заката
struct Sys: Codable {
//    рассвет
    let sunrise: Int
//    закат
    let sunset: Int
}

