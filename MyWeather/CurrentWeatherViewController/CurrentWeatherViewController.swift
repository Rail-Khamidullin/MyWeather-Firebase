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
    
    //    Создаём св-во для присвоения предпоследнего запроса города
    var cityBeforeLast: String = "Город"
    //    Создаём массив с запросами городов для отображения предпоследнего города на 3 контроллере
    var cityArray: [String] = []
    //    Массив со всеми запрошенными городами у данного пользователя
    var cityArrayUser = [City]()
    //    Создаём экземпляр класса DataFetcherService
    let dataFetcherService = DataFetcherService()
    //    Создаём зависимость с абстракцией DataBaseProtocol
    private var dataBase: DataBaseProtocol?
    //    Инициализируем CurrentWeatherView
    let currentWeatherView = CurrentWeatherView()
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
        //        Передадим массив с городами из Firebase в массив текущего контроллера
        dataBase?.observeCity(cityArray: { [weak self] (citiesArray) in
            self?.cityArrayUser = citiesArray
        })
    }
    
    //    Экран уже загрузился
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Зависимость с DataBase через абстракцию DataBaseProtocol
        dataBase = RealTimeDataBase()
        //        Фон нашего view
        view.backgroundColor = .white
        //        Добавляем WeatherView в view
        view.addSubview(currentWeatherView)
        //        Привязка WeatherView к экрану
        currentWeatherView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        //        Подписал текстовое поле под делегат, для работы дополнительных функций в клавиатуре
        currentWeatherView.cityTextField.delegate = self
        //        Вызов метода, который обновит интерфейс приложения по полученным данным с сервера
        dataFetcherService.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            //            Обнавляем интерфейс
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
        //        Создаём пользователя в Firebase
        dataBase?.createUser()
    }
    
    //    Отображение экрана будет завершено
    override func viewWillDisappear(_ animated: Bool) {
        //        Выход из приложения погода в Firebase и закрытие экрана
        backButtonPressed()
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
            //            Присваиваем значение предпоследнего города из массива нашему св-ву
            cityBeforeLast = nameCity
        } else {
            //            Находим название предпоследнего города из массива
            let nameCity = cityArray[numberBeforeLast]
            //            Присваиваем введённое название города в наше св-во
            cityBeforeLast = nameCity
        }
    }
    
    //    По нажатию на кнопку ввода, город с текстового поля будет передан в GET запрос. Обновлён предпоследний запрос города и добавлен город в dataBase
    @objc private func myButtonPressed(_ sender: UIButton) {
        getCityName { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
            //            Добавляем его в массив с названиями городов
            self.cityArray.append(city)
            //            Добавляем новый город в dataBase
            self.dataBase?.saveCity(city: city)
        }
        //            Обновляем нашу переменную cityBeforeLast
        addCityBeforeLast()
    }
    
    //    По нажатию на кнопку будет переход на следующий экран показывающий текущую погоду по предыдущему запросу
    @objc private func lastButtonPressed(_ sender: UIButton) {
        //        Достаём третий контроллер
        let lastWeatherViewController = LastWeatherViewController()
        //        Передаём название города во третий контроллер
        lastWeatherViewController.nameCity = self.cityBeforeLast
        //        Совершаем переход на следующий контроллер
        self.navigationController?.pushViewController(lastWeatherViewController, animated: true)
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

