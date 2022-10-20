//
//  ViewController.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import UIKit
import SnapKit
import CoreLocation
import Firebase

final class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    //    Создаём зависимость с DataBase
    private var dataBase: DataBaseProtocol?
    //    Инициализируем CurrentWeatherView
    let currentWeatherView = CurrentWeatherView()
    //    Создаём св-во для присвоения предпоследнего запроса города
    var cityBeforeLast: String = ""
    //    Создаём экземпляр класса DataFetcherService
    let dataFetcherService = DataFetcherService()
    //    Создаём массив с запросами городов и типом будет выступать наша сущность City
    var cityArray: [String] = []
    //    Создаём экземпляр класса Animator (анимация объектов)
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
    
    //    Экран будет отображён
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        Добавим анимацию для картинки с погодными условиями
        animate.animateAnyObjects(animateObject: currentWeatherView.weatherIconImageView)
    }
    
    //    Экран уже загрузился
    override func viewDidLoad() {
        super.viewDidLoad()
        dataBase = DataBase()
        //        Фон нашего view
        view.backgroundColor = .white
        //        Добавляем WeatherView в view
        view.addSubview(currentWeatherView)
        //        Привязка WeatherView к экрану
        currentWeatherView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //        Ввод текста происходит на английском языке. Метод, который не позволяет открыть клавиатуру на русском
        currentWeatherView.cityTextField.keyboardType = .asciiCapable
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        //        Подписал текстовое поле под делегат, для работы дополнительных функций в клавиатуре
        currentWeatherView.cityTextField.delegate = self
        //        Вызов метода, который обновит интерфейс приложения по полученным данных с сервера
        dataFetcherService.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.currentWeatherView.updateInterfaceWith(weather: currentWeather)
        }
        //        У пользователя может быть отключена настройка геопозиции (общая настройка в телефоне), для этого проверяем locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        //        Добавим таргет к кнопке поиска погоды
        currentWeatherView.searchWeatherButton.addTarget(self, action: #selector(myButtonPressed(_:)), for: .primaryActionTriggered)
        //        Добавляем таргет для перехода на следующий экран
        currentWeatherView.lastCityButton.addTarget(self, action: #selector(lastButtonPressed(_:)), for: .primaryActionTriggered)
        //        Отображаем навигейшн бар
        navigationController?.navigationBar.isHidden = false
        //        Настраиваем кнопку навигационного контроллера
        navigationController?.setBackButton(with: "Назад")
        
        dataBase?.createUser()
    }
    
    //    Отображение экрана будет завершено
    override func viewWillDisappear(_ animated: Bool) {
        //        Выход из приложения погода в Firebase и закрытие экрана
        backButtonPressed()
    }
    
    //    Метод по сохранению названия городов в массиве cityArray
    private func saveCity(nameCity name: String) {
        //            добавляем его в массив с названиями городов
        cityArray.append(name)
    }
    
    //    Метод, который находит в массиве предпоследний запрос и передаёт его в переменную cityBeforeLast для дальнейшей обработки
    private func addCityBeforeLast() {
        
        //        Предпоследний порядковый номер массива
        var numberBeforeLast = 0
        
        //        Через инструкцию находим предпоследнее название города и присваиваем нашей переменной
        if cityArray.count > 1 {
            //            Берём предпоследний порядковый номер из массива с городами
            numberBeforeLast = cityArray.count - 2
            //            Находим название предпоследнего города из массива
            let nameCity = cityArray[numberBeforeLast]
            
            self.cityBeforeLast = nameCity
        } else {
            //            Находим название предпоследнего города из массива
            let nameCity = cityArray[numberBeforeLast]
            //            Присваиваем введённое название города в массив запросов городов
            cityBeforeLast = nameCity
        }
    }
    
    //    По нажатию на кнопку ввода, город с текстового поля будет передан в GET запрос
    @objc private func myButtonPressed(_ sender: UIButton) {
        getCityName { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
            //            Сохранение запроса города в памяти и добавление в массив cityArray
            saveCity(nameCity: city)
            //            Обновляем нашу переменную cityBeforeLast
            addCityBeforeLast()
            
            dataBase?.saveCity(city: city)
        }
    }
    
    //    По нажатию на кнопку будет переход на следующий экран показывающий текущую погоду по предыдущему запросу
    @objc private func lastButtonPressed(_ sender: UIButton) {
        //        Достаём второй контроллер
        let lastWeatherViewController = LastWeatherViewController()
        //        Передаём название города во второй контроллер
        lastWeatherViewController.nameCity = self.cityBeforeLast
        //        Совершаем переход на следующий контроллер
        navigationController?.pushViewController(lastWeatherViewController, animated: true)
    }
    
    //    Выход из приложения погода в Firebase и закрытие экрана
    private func backButtonPressed() {
        do {
            try Firebase.Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
}

