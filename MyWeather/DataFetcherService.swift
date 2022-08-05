//
//  DataFetcherService.swift
//  MyWeather
//
//  Created by Rail on 23.06.2022.
//

import Foundation
import CoreLocation

//   Класс несёт только одну ответственность
final class DataFetcherService {
    
    //    Создаём клоужер, который принимает структуру CurrentWeather
    var onCompletion: ((CurrentWeather) -> ())?
    
    //    Создаём внешнюю зависимость с NetworkDataFetcher через Абстракцию (протокол DataFetcher)
    private let dataFetcher: DataFetcher
    
//    Конструктор для заисимости с клсассом NetworkDataFetcher через абстракцию
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        
        self.dataFetcher = dataFetcher
    }
    
    //    Энум будет определять город в зависимости от координат расположения устройства или введённого города в ручную
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        
    }
    
    //    Получаем декодированные данные по структуре входящего ответа с сервера и передаём далее
    private func fetchCurrentWeatherData(urlString: String, completion: @escaping (CurrrentWeatherData?) -> ()) {
        dataFetcher.genericJSONData(urlString: urlString, response: completion)
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
        
        //        Присваиваем полученные декодированные данные weather и обновляем структуру данных CurrentWeather
        let weather = self.fetchCurrentWeatherData(urlString: urlString) { [weak self] (currentWeatherData) in
            
            if let currentWeatherData = currentWeatherData {
                //                Передаём в форму нашей текущей погоды данные по текущей погоде с сервера
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return }
                self?.onCompletion?(currentWeather)
            }
        }
    }
}
