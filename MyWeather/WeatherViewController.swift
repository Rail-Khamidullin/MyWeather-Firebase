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
    var feelsTempStackView = UIStackView()
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
    //    Стек с рассветом
    var sunriseStackView = UIStackView()
    //    Рассвет
    var sunriseLable = UILabel()
    //    Врремя рассвета
    var sunriseLableTime = UILabel()
    //    Стек с закатом
    var sunsetStackView = UIStackView()
    //    Закат
    var sunsetLable = UILabel()
    //    Врремя заката
    var sunsetLableTime = UILabel()
    //    Поле для ввода города
    var cityTextField = UITextField()
    //    Кнопка поиска погоды
    var searchWeatherButton = UIButton(type: .system)
    
    //    Инициализируем класс WeatherView со свойствами отображаемых объектов
    final let weatherView = WeatherView()
    
//    Подготовлен для удаления
    /*
     //    Инициализируем Вью
     var myView: WeatherView? {
     didSet {
     guard let myView = myView else { return }
     self.scrollView = myView.scrollView
     self.imageView = myView.imageView
     self.weatherIconImageView = myView.weatherIconImageView
     self.mainStackView = myView.mainStackView
     self.tempStackView = myView.tempStackView
     self.tempLable = myView.tempLable
     self.tempCurrentLable = myView.tempCurrentLable
     self.feelsTempStackView = myView.feelsStackView
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
     self.sunriseStackView = myView.sunriseStack
     self.sunriseLable = myView.sunriseLable
     self.sunriseLableTime = myView.sunriseLableTime
     self.sunsetStackView = myView.sunsetStack
     self.sunsetLable = myView.sunsetLable
     self.sunsetLableTime = myView.sunsetLableTime
     self.cityTextField = myView.cityTextField
     self.searchWeatherButton = myView.searchWeatherButton
     }
     }
     */
    
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
        
        //        myView = WeatherView()
        
        //        Добавляем свойства для отображаемых объектов
        addPropertyObjectView()
        
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
    
    //    Добавление св-в для объектов View
    private func addPropertyObjectView() {
        
//        Фон приложения
        weatherView.imageView(imageView: imageView)
//        Вьюшка с рисунком обозначающую погоду
        weatherView.weatherIconImageView(iconImage: weatherIconImageView)
        
//        Главный стек
        weatherView.mainStackView(stackView: mainStackView)
        //        Стек с текущей температурой
        weatherView.weatherStackView(stackView: tempStackView)
//        Стек с текущей ощущаемой температурой
        weatherView.weatherStackView(stackView: feelsTempStackView)
//        Стек с давлением
        weatherView.weatherStackView(stackView: pressureStackView)
//        Стек со скоростью ветра
        weatherView.weatherStackView(stackView: windStackView)
//        Стек с влажностью
        weatherView.weatherStackView(stackView: humidityStackView)
//        Стек с временем рассвета
        weatherView.weatherStackView(stackView: sunriseStackView)
//        Стек с временм заката
        weatherView.weatherStackView(stackView: sunsetStackView)
        
//        Лейбл с температурой
        weatherView.weatherLable(lable: tempLable, text: "Температура, °C")
//        Лейбл с текущей температурой
        weatherView.weatherLable(lable: tempCurrentLable, text: "")
//        Лейбл с ощущаемой температурой
        weatherView.weatherLable(lable: feelsTempLable, text: "Ощущается, °C")
//        Лейбл с текущей ощущаемой температурой
        weatherView.weatherLable(lable: feelsCurrentTempLable, text: "")
//        Лейбл с давлением
        weatherView.weatherLable(lable: pressureLable, text: "Давление, гПа")
//        Лейбл с текущим давлением
        weatherView.weatherLable(lable: pressureCurrentLable, text: "")
//        Лейбл с ветром
        weatherView.weatherLable(lable: windLable, text: "Скорость ветра, м/с")
//        Лейбл со скоростью ветра
        weatherView.weatherLable(lable: windCurrentLable, text: "")
//        Лейбл с влажностью
        weatherView.weatherLable(lable: humidityLable, text: "Влажность воздуха, %")
//        Лейбл с текущей влажностью
        weatherView.weatherLable(lable: currentHumidityLable, text: "")
//        Лейбл с рассетом
        weatherView.weatherLable(lable: sunriseLable, text: "Рассвет, час:мин:сек")
//        Лейбл с временем рассвета
        weatherView.weatherLable(lable: sunriseLableTime, text: "")
//        Лейбл с закатом
        weatherView.weatherLable(lable: sunsetLable, text: "Закат, час:мин:сек")
        //        Лейбл с временем закатом
        weatherView.weatherLable(lable: sunsetLableTime, text: "")
//        Лейбл с описанием погоды
        weatherView.weatherLable(lable: condition, text: "Описание")
        
//        Текстовое поле для ввода города
        weatherView.cityTextField(textField: cityTextField)
//        Кнопка поиска погоды
        weatherView.searchWeatherButton(button: searchWeatherButton)
    }
    
    //    По нажатию на кнопку ввода город с текстового поля будет передан в GET запрос
    @objc private func myButtonPressed(_ sender: UIButton) {
        broadcastText { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
        }
    }
    
    //    Обновление интерфейса приложения асинхронно через главную очередь
    private func updateInterfaceWith(weather: CurrentWeather) {
        
        DispatchQueue.main.async {
            self.tempCurrentLable.text = weather.currentTemperature
            self.feelsCurrentTempLable.text = weather.currentFeelsTemperature
            self.pressureCurrentLable.text = weather.currentPressure
            self.windCurrentLable.text = weather.currentSpeedWind
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
            self.currentHumidityLable.text = weather.currentHumidity
            self.condition.text = weather.dictionaryWeather
            self.sunriseLableTime.text = weather.currentSunrise
            self.sunsetLableTime.text = weather.currentSunset
        }
    }
}

