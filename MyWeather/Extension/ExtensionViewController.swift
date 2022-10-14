//
//  ExtensionViewController.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation
import UIKit
import CoreLocation


extension CurrentWeatherViewController {
    
    //    Метод для поднятия на необходимую высоту и скрытия клавиатуры по нажатию на кнопку return
    func tapGester() {
        //        Скрытие клавиатуры по нажатию на экран
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        //        Добавить распознавание
        view.addGestureRecognizer(tapGesterRecognizer)
        //        Скрытие клавиатуры по нажатию на кнопку ввод (return)
        currentWeatherView.cityTextField.addTarget(self, action: #selector(keyboardWillHide), for: .primaryActionTriggered)
    }
    
    //    Получение данных по клавиатуре
    func connectToNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    //    Открытие клавиатуры с поднятием текстового поля на высоту клавиатуры + 5 пойнтов
    @objc private func keyboardDidShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardHeihgt = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        //        Поднимаем наш скрол на высоту клавиатуры + 5 пойнтов
        currentWeatherView.scrollView.contentInset.bottom = keyboardHeihgt.height + 49
    }
    
    //    Скрытие клавиатуры
    @objc private func keyboardWillHide() {
        currentWeatherView.scrollView.contentInset.bottom = 0
        view.endEditing(true)
    }
    
    //    Достаём город из текстового поля и передаём далее, предварительно соединив 2 слова в случае если город состоит из двух слов
    func getCityName(completion: @escaping (String) -> ()) {
        
        guard let cityName = currentWeatherView.cityTextField.text else { return }
        if cityName != "" {
            //            Убираем пробел между словами для поиска города
            let city = cityName.split(separator: " ").joined(separator: "%20")
            //            Передаём дальше
            return completion(city)
        }
    }
    
    //    MARK: - UITextFieldDelegate
    
    //    Очистка текстового поля при новом обращению к нему
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentWeatherView.cityTextField.text = ""
        return true
    }
}

extension CurrentWeatherViewController {
    
    ///    Достаём расположение девайса
    //     Реализуем метод, где отрабатываем различные ситуации с локацией, а именно с отключенной и включенной настройкой в девайсе
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        Получаем последнее месторасположение из массива CLLocation. Геопозиция по широте и долготе
        guard let location = locations.last else { return }
        //        Координата широты
        let latitude = location.coordinate.latitude
        //        Координата долготы
        let longitude = location.coordinate.longitude
        //        Метод чтобы получить погоду по текущему расположению
        dataFetcherService.fetchCurrentWeather(forRequstType: .coordinate(latitude: latitude, longitude: longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
