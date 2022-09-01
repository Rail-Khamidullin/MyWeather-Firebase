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
    
    //    Энум будет хранить направление откуда пришёл запрос на определение погоды (город или месторасположение)
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    //    Создаём клоужер, который принимает структуру CurrentWeather
    var onCompletion: ((CurrentWeather) -> ())?
    
    //    Создаём внешнюю зависимость с NetworkDataFetcher через Абстракцию (протокол DataFetcher)
    private let dataFetcher: DataFetcher
    
    //    Конструктор для зависимости с клсассом NetworkDataFetcher через абстракцию
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        
        self.dataFetcher = dataFetcher
    }
    
    //    Получаем декодированные данные по структуре входящего ответа с сервера и передаём далее
    private func fetchCurrentWeatherData(urlString: String, completion: @escaping (CurrrentWeatherData?) -> ()) {
        dataFetcher.genericJSONData(urlString: urlString, response: completion)
    }
    
    //    Получаем текущую погоду
    func fetchCurrentWeather(forRequstType requestType: RequestType) {
        
        //        Создаём переменную, которую будем присваивать нужному url в зависимости от запроса
        let urlString: String
        //        Поиск по локации или по городу
        switch requestType {
        //        Если получили в запросе город, то идёт запрос погоды в городе
        case .cityName(city: let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(weatherApiKey)&lang=ru&units=metric&lang=ru"
        //        Если получили в запросе расположение, то идёт запрос погоды по геопозиции
        case .coordinate(latitude: let latitude, longitude: let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&long=\(longitude)&apikey=\(weatherApiKey)&units=metric&lang=ru"
        }
        
        //        Присваиваем полученные декодированные данные weather и обновляем структуру данных CurrentWeather
        let weather = self.fetchCurrentWeatherData(urlString: urlString) { [weak self] (currentWeatherData) in
            
            if let currentWeatherData = currentWeatherData {
                //                Передаём в форму нашей текущей погоды данные по текущей погоде с сервера
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return }
                //                Передаём полученную модель в клоужер для дальнейшего применения
                self?.onCompletion?(currentWeather)
            }
        }
    }
}
