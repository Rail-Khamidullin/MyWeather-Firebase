//
//  ViewController.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //    Скролл
    var scrollView = UIScrollView()
    //    Основная вьюшка на весь экран
    var imageView = UIImageView()
    //    Картинка отображения погодных условий
    var weatherIconImageView = UIImageView()
    //    Главный стек
    var mainStackView = UIStackView()
    //    Стек для температуры
    var tempStackView = UIStackView()
    //    Лейбл температуры
    var tempLable = UILabel()
    //    Текущая температура
    var tempCurrentLable = UILabel()
    //    Стек для ощущаемой температуры
    var feelsStackView = UIStackView()
    //    Ощущаемая температура
    var feelsTempLable = UILabel()
    //    Текущая ощущаемая температура
    var feelsCurrentTempLable = UILabel()
    //    Стек для давления
    var pressureStackView = UIStackView()
    //    Атмосферное давление
    var pressureLable = UILabel()
    //    Текущее давление
    var pressureCurrentLable = UILabel()
    //    Стек для ветра
    var windStackView = UIStackView()
    //    Скорость ветра
    var windLable = UILabel()
    //    Текущая скорость ветра
    var windCurrentLable = UILabel()
    //    Погодное описание
    var condition = UILabel()
    //    Стек влажности
    var humidityStackView = UIStackView()
    //    Влажность
    var humidityLable = UILabel()
    //    Текущая влажность
    var currentHumidityLable = UILabel()
    //    Поле для ввода города
    var cityTextField = UITextField()
    //    Кнопка поиска погоды
    var searchWeatherButton = UIButton(type: .system)
    
    //    Инициализируем Вью
    var myView: MyView? {
        didSet {
            guard let myView = myView else { return }
            self.scrollView = myView.scrollView
            self.imageView = myView.imageView
            self.weatherIconImageView = myView.weatherIconImageView
            self.mainStackView = myView.mainStackView
            self.tempStackView = myView.tempStackView
            self.tempLable = myView.tempLable
            self.tempCurrentLable = myView.tempCurrentLable
            self.feelsStackView = myView.feelsStackView
            self.feelsTempLable = myView.feelsTempLable
            self.feelsCurrentTempLable = myView.feelsCurrentTempLable
            self.pressureStackView = myView.pressureStackView
            self.pressureLable = myView.pressureLable
            self.pressureCurrentLable = myView.pressureCurrentLable
            self.windStackView = myView.windStackView
            self.windLable = myView.windLable
            self.windCurrentLable = myView.windCurrentLable
            self.condition = myView.condition
            self.humidityStackView = myView.humidityStack
            self.humidityLable = myView.humidityLable
            self.currentHumidityLable = myView.currentHumidityLable
            self.cityTextField = myView.cityTextField
            self.searchWeatherButton = myView.searchWeatherButton
        }
    }
    
    //    Создаём экземпляр класса DataFetcherService
    let dataFetcherService = DataFetcherService()
    //    Создаём экземпляр класса Animator
    let animate = Animator()
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
        
        myView = MyView()
        //        Добавление объектов на экран
        addObjectView()
        //        Расположение объектов на экране
        configureView()
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        
        cityTextField.delegate = self
        
        //        Вызов метода, который обновит интерфейс приложения по полученным данным с сервера
        dataFetcherService.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)
        }
        //        Добавим таргет к кнопке поиска погоды
        searchWeatherButton.addTarget(self, action: #selector(myButtonPressed(_:)), for: .primaryActionTriggered)
        //        Добавим анимацию для картинки с погодными условиями
        animate.animateAnyObjects(animateObject: weatherIconImageView)
    }
    
    //    По нажатию на кнопку ввода город с текстового поля будет передан в GET запрос
     @objc private func myButtonPressed(_ sender: UIButton) {
        broadcastText { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
        }
    }
    
    //    Обновление интерфейса приложения
   private func updateInterfaceWith(weather: CurrentWeather) {
        
        DispatchQueue.main.async {
            self.tempCurrentLable.text = weather.currentTemperature
            self.feelsCurrentTempLable.text = weather.currentFeelsTemperature
            self.pressureCurrentLable.text = weather.currentPressure
            self.windCurrentLable.text = weather.currentSpeedWind
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
            self.currentHumidityLable.text = weather.currentHumidity
            self.condition.text = weather.dictionaryWeather
        }
    }
}

