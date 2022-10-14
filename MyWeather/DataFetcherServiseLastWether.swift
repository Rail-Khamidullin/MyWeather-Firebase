//
//  DataFetcherServiseLastWether.swift
//  MyWeather
//
//  Created by Rail on 14.10.2022.
//

import Foundation

//   Класс реализует GET запрос и обновление интерфейса
final class DataFetcherServiceSC {
    
    //    Создаём клоужер, который принимает структуру CurrentWeather
    var onCompletionSC: ((CurrentWeather) -> ())?
    
    //    Создаём внешнюю зависимость
    var dataFetcher: DataFetcher
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    //    Получаем текущую погоду
    func fetchCurrentWeatherSC(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(weatherApiKey)&lang=ru&units=metric&lang=ru"
        
        //        Присваиваем полученные данные weather и обновляем структуру данных CurrentWeather
        let weather = self.fetchCurrentWeatherData(urlString: urlString) { [weak self] (currentWeatherData) in
            
            if let currentWeatherData = currentWeatherData {
                //                Передаём в форму нашей текущей погоды данные по текущей погоде с сервера
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return }
                self?.onCompletionSC?(currentWeather)
            }
        }
    }
    
    //    Получаем декодированные данные по структуре входящего ответа с сервера и передаём далее
    private func fetchCurrentWeatherData(urlString: String, completion: @escaping (CurrrentWeatherData?) -> ()) {
        dataFetcher.genericJSONData(urlString: urlString, response: completion)
    }
}
