//
//  NetworkDataFetcher.swift
//  MyWeather
//
//  Created by Rail on 23.06.2022.
//

import Foundation

//   Фиксируем метод поведения в целом, таким образом его нельзя будет изменить после подписки
protocol DataFetcher {
    
    /// GET запрос
    /// - Parameters:
    ///   - urlString: url любого сервиса, в нашем случае запрос погоды
    ///   - response: получение декодированного ответа  любого типа и передача его в любую модель данных
    func genericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> ())
}

//   Класс, который возвращает декодированные данные для любой модели
final class NetworkDataFetcher: DataFetcher {
    
    //    Установим внешнюю зависимость, таким образом класс будет зависеть от Абстракции (protocol)
    fileprivate let networking: Networking
    
    //    Создаём конструктор для нашей абстрактной зависимости от Network, которая равна классу NetworkService
    init(networking: Networking = NetworkService()) {
        
        self.networking = networking
    }
    
    //     GET запрос
    func genericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> ()) {
        
        networking.request(urlString: urlString) { [weak self] (data, error) in
            if let error = error {
                print("Error recived requesting data \(error.localizedDescription)")
                response(nil)
            }
            //            Получаем декодированные данные и передаём далее
            let decoded = self?.genericDecodeJSON(type: T.self, data: data)
            response(decoded)
        }
    }
    
    //    Декодируем данные
    private func genericDecodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        
        let jsonDecoder = JSONDecoder()
        guard let data = data else {
            //        Проверка входящих данных в случае ошибки
            print("Данные для декодинга не получены!")
            
            return nil
        }
        
        do {
            //            Если декодировать удалось,
            let objects = try jsonDecoder.decode(type.self, from: data)
            //            то возвращаем декодированные данные
            return objects
        } catch {
            print(error)
        }
        return nil
    }
}
