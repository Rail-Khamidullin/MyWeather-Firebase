//
//  CurrentWeather.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation

//   Модель данных куда будем присваивать данные из сервера
struct CurrentWeather: Decodable {
    
    //    Город
    let cityName: String
    //    Текущая температура
    let temp: Double
    //    Ощущаемая температура
    let feelsTemp: Double
    //    Давление
    let pressure: Int
    //    Скорость ветра
    let speedWind: Double
    //    Влажность
    let humidity: Int
    //    Рассвет
    let sunrise: Int
    //    Закат
    let sunset: Int
    
    //    Теущая температура
    var currentTemperature: String {
        //        Поскольку наш Лейбл принимает только значения Стринг, преобразуем значение температуры в Стринг. Возвращаем форматированную строку, где указываем кол-во чисел после запятой, в нашем случае 0
        return String(format: "%.0f", temp)
    }
    
    //    Текущая ощущаемая температура
    var currentFeelsTemperature: String {
        //        Возвращаем форматированную строку, где указываем кол-во чисел после запятой, в нашем случае 0
        return String(format: "%.0f", feelsTemp)
    }
    
    //    Возвращаем стринговое значение давлению
    var currentPressure: String {
        return String(pressure)
    }
    
    //    Возвращаем стринговое значение скорости ветра
    var currentSpeedWind: String {
        return String(format: "%.0f", speedWind)
    }
    
    //    Возвращаем стринговое значение влажности
    var currentHumidity: String {
        return String(humidity)
    }
    
    //    Возвращаем стринговое значение рассвету
    var currentSunrise: String {
        //        Конвертируем полученную данные из Unix в часы, минуты и секунды
        let epochDate = Date(timeIntervalSince1970: TimeInterval(sunrise) as TimeInterval)
        let calendar = Calendar.current
        //        Часы
        let epochHour = calendar.component(.hour, from: epochDate)
        //        Минуты
        let epochMinute = calendar.component(.minute, from: epochDate)
        //        Секунды
        let epochSecond = calendar.component(.second, from: epochDate)
        //        Соединяем в удобочитаемый вид
        let sunriseTime = "\(epochHour):\(epochMinute):\(epochSecond)"
        
        return String(sunriseTime)
    }
    
    //    Возвращаем стринговое значение закату
    var currentSunset: String {
        //        Конвертируем полученную данные из Unix в часы, минуты и секунды
        let epochDate = Date(timeIntervalSince1970: TimeInterval(sunset) as TimeInterval)
        //        Для проверки
        print(epochDate)
        
        let calendar = Calendar.current
        //        Часы
        let epochHour = calendar.component(.hour, from: epochDate)
        //        Минуты
        let epochMinute = calendar.component(.minute, from: epochDate)
        //        Секунды
        let epochSecond = calendar.component(.second, from: epochDate)
        //        Соединяем в удобочитаемый вид
        let sunsetTime = "\(epochHour):\(epochMinute):\(epochSecond)"
        
        return String(sunsetTime)
    }
    
    //    id - цифровое значение, полученоое от сервера, которое имеет краткое описание текущей погоды
    let conditionCode: Int
    
    //    Напишем доп св-ва, чтобы подставить в метод по обновлению интерфейса приложения. conditionCode мы получаем с сайта"
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    //    Напишем доп св-ва для добавления описания
    var dictionaryWeather: String {
        switch conditionCode {
        case 200...232:
            return "Гроза"
        case 300...321:
            return "Моросящий дождь"
        case 500...531:
            return "Дождь"
        case 600...622:
            return "Снег"
        case 701...781:
            return "Туман"
        case 800:
            return "Ясно"
        case 801...804:
            return "Облачно"
        default:
            return ""
        }
    }
    
    //    Иницализатор, который соединяет модель с данными, полученными от сервера с моделью нашего проекта для обновления интерфейса
    init?(currentWeatherData: CurrrentWeatherData) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        feelsTemp = currentWeatherData.main.feelsLike
        pressure = currentWeatherData.main.pressure
        speedWind = currentWeatherData.wind.speed
        humidity = currentWeatherData.main.humidity
        sunrise = currentWeatherData.sys.sunrise
        sunset = currentWeatherData.sys.sunset
        conditionCode = currentWeatherData.weather.first!.id
    }
}
