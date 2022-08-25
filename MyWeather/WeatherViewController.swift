//
//  ViewController.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //    Инициализируем WeatherView
    let weatherView = WeatherView()
    
    //    Создаём экземпляр класса DataFetcherService
    let dataFetcherService = DataFetcherService()
    //    Создаём экземпляр класса Animator
    private let animate = Animator()
    //    Создаём менеджера, который будет с приставкой lazy. Если пользователь откажет в предоставлении месторасположения, методы не будут находиться в памяти
    fileprivate lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        //    Необходимо указать точность с которой мы хотим получать информацию. kCLLocationAccuracyKilometer укзывает на точность в километр
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //        Запрашиваем пользователя к доступу его геопозиции
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Фон нашего view
        view.backgroundColor = .white
        //        Добавляем WeatherView в view
        view.addSubview(weatherView)
        
        //        Привязка WeatherView к экранау
        weatherView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        
        weatherView.cityTextField.delegate = self
        
        //        Вызов метода, который обновит интерфейс приложения по полученным данным с сервера
        dataFetcherService.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.weatherView.updateInterfaceWith(weather: currentWeather)
        }
        //        Добавим таргет к кнопке поиска погоды
        weatherView.searchWeatherButton.addTarget(self, action: #selector(myButtonPressed(_:)), for: .primaryActionTriggered)
        //        Добавим анимацию для картинки с погодными условиями
        animate.animateAnyObjects(animateObject: weatherView.weatherIconImageView)
    }
    
    //    По нажатию на кнопку ввода, город с текстового поля будет передан в GET запрос
    @objc private func myButtonPressed(_ sender: UIButton) {
        getCityName { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
        }
    }
}

