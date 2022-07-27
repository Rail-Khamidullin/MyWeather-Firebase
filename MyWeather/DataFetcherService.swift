//
//  DataFetcherService.swift
//  MyWeather
//
//  Created by Rail on 23.06.2022.
//

import Foundation
import CoreLocation

//   Класс несёт только одну ответственность
class DataFetcherService {
    
    //    Создаём клоужер, который принимает структуру CurrentWeather
    var onCompletion: ((CurrentWeather) -> ())?
    
//    Создаём внешнюю зависимость
    var dataFetcher: DataFetcher
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
//    Энум будет определять город в зависимости от координат расположения устройства или введённого города в ручную
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        
    }
    
//    Получаем текущую погоду
    func fetchCurrentWeather(forRequstType requestType: RequestType) {
        
        var urlString = ""
//        Поиск по локации или по городу
        switch requestType {
        case .cityName(city: let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(weatherApiKey)&lang=ru&units=metric&lang=ru"
        case .coordinate(latitude: let latitude, longitude: let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&long=\(longitude)&apikey=\(weatherApiKey)&units=metric&lang=ru"
        }
        
//        Присваиваем полученные данные weather и обновляем структуру данных CurrentWeather
        let weather = self.fetchCurrentWeatherData(urlString: urlString) { (currentWeatherData) in

            if let currentWeatherData = currentWeatherData {
//                Передаём в форму нашей текущей погоды данные по текущей погоде с сервера
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return }
                self.onCompletion?(currentWeather)
            }
        }
        }
    
//    Получаем декодированные данные по структуре входящего ответа с сервера и передаём далее
    func fetchCurrentWeatherData(urlString: String, completion: @escaping (CurrrentWeatherData?) -> ()) {
    dataFetcher.genericJSONData(urlString: urlString, response: completion)
    }
}
