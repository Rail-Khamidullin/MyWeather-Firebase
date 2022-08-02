//
//  NetworkServise.swift
//  MyWeather
//
//  Created by Rail on 22.06.2022.
//

import Foundation

//   Фиксируем метод поведения в целом, таким образом его нельзя будет изменить после подписки
protocol Networking {
    
    //    Построение запроса данных по URL и передача
    func request(urlString: String, completion: @escaping (Data?, Error?) -> ())
}

//   Запрос на получение данных и передачу для дальнейшего парсинга в модель погоды для запроса по любому url и любой модели данных
final class NetworkService: Networking {
    
    //    Построение запроса данных по URL и передача
    func request(urlString: String, completion: @escaping (Data?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = self.createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    //    Получение данных
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        //        Создаём сессию
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        return dataTask
    }
}
