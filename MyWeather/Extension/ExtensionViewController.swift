//
//  ExtensionViewController.swift
//  MyWeather
//
//  Created by Rail on 31.05.2022.
//

import Foundation
import UIKit
import CoreLocation

extension WeatherViewController {
    
    //    Добавление объектов на экран
    func addObjectView() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(imageView)
        scrollView.addSubview(weatherIconImageView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(tempStackView)
        mainStackView.addArrangedSubview(feelsTempStackView)
        mainStackView.addArrangedSubview(pressureStackView)
        mainStackView.addArrangedSubview(windStackView)
        mainStackView.addArrangedSubview(humidityStackView)
        mainStackView.addArrangedSubview(sunriseStackView)
        mainStackView.addArrangedSubview(sunsetStackView)
        tempStackView.addArrangedSubview(tempLable)
        tempStackView.addArrangedSubview(tempCurrentLable)
        feelsTempStackView.addArrangedSubview(feelsTempLable)
        feelsTempStackView.addArrangedSubview(feelsCurrentTempLable)
        pressureStackView.addArrangedSubview(pressureLable)
        pressureStackView.addArrangedSubview(pressureCurrentLable)
        windStackView.addArrangedSubview(windLable)
        windStackView.addArrangedSubview(windCurrentLable)
        humidityStackView.addArrangedSubview(humidityLable)
        humidityStackView.addArrangedSubview(currentHumidityLable)
        sunriseStackView.addArrangedSubview(sunriseLable)
        sunriseStackView.addArrangedSubview(sunriseLableTime)
        sunsetStackView.addArrangedSubview(sunsetLable)
        sunsetStackView.addArrangedSubview(sunsetLableTime)
        mainStackView.addArrangedSubview(condition)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(searchWeatherButton)
    }
    
    //    Расположение объектов на экране
     func configureView() {
        //        Скролл
        scrollView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalToSuperview()
        }
        //        Фон
        imageView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
            maker.centerX.centerY.equalToSuperview()
        }
        //        Иконка с погодой
        weatherIconImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(20)
            maker.centerX.equalToSuperview()
            maker.height.width.equalTo(140)
        }
        //        Главный стек
        mainStackView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(10)
            maker.top.equalTo(weatherIconImageView.snp.bottom).offset(5)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(237)
        }
        //        Температура
        tempLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Ощущаемая температура
        feelsTempLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Давление
        pressureLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Скорость ветра
        windLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
//        Рассвет
        sunriseLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
//        Закат
        sunsetLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Описание
        condition.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
        }
        //        Влажность
        humidityLable.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Поле для ввода города
        cityTextField.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(20)
            maker.top.equalTo(mainStackView.snp.bottom).offset(20)
        }
        //        Кнопка поиска погоды
        searchWeatherButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(cityTextField.snp.bottom).offset(20)
            maker.width.equalTo(100)
            maker.height.equalTo(35)
            maker.centerX.equalToSuperview()
        }
    }
}

extension WeatherViewController {
    
//    Метод для открытия и скрытия клавиатуры по нажатию на кнопку returne
    func tapGester() {
//        Скрытие клавиатуры по нажатию на экран
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapGesterRecognizer)
//        Скрытие клавиатуры по нажатию на кнопку ввод
        cityTextField.addTarget(self, action: #selector(keyboardWillHide), for: .primaryActionTriggered)
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
        
        scrollView.contentInset.bottom = keyboardHeihgt.height + 7
    }
    
//    Скрытие клавиатуры
    @objc private func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        view.endEditing(true)
    }
    
//    Достаём город из текстового поля и передаём далее, предварительно соединив 2 слова в случае если город состоит из двух слов
     func broadcastText(completion: @escaping (String) -> ()) {
        
        guard let cityName = cityTextField.text else { return }
        if cityName != "" {
            print(cityName)
            let city = cityName.split(separator: " ").joined(separator: "%20")
            
            return completion(city)
        }
    }
}

extension WeatherViewController {
    
    ///    Достаём расположение девайса
    //            Реализуем метод, где отрабатываем различные ситуации с локацией, а именно с отключенной настройкой в девайсе и включенной
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        Получаем последнее месторасположение из массива CLLocation. Геопозиция по широте и долготе
        guard let location = locations.last else { return }
        //        Координата широты
        let latitude = location.coordinate.latitude
        //        Координата долготы
        let longitude = location.coordinate.longitude
        
        //        Метод чтобы получить погоду по текущему расположению
        dataFetcherService.fetchCurrentWeather(forRequstType: .coordinate(latitude: latitude, longitude: longitude))
    }
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //    MARK: - UITextFieldDelegate
    
    //    Очистка текстового поля при новом обращению к нему
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cityTextField.text = ""
        return true
    }
}
