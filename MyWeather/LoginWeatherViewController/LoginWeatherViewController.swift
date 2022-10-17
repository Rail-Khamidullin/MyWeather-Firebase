//
//  LoginWeatherViewController.swift
//  MyWeather
//
//  Created by Rail on 17.10.2022.
//

import UIKit
import SnapKit
import CoreLocation
import Firebase

class LoginWeatherViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
//    Создаём нового пользвателя
    var user: Users!
//    Через референс мы можем добраться до нужных нам данных (некий проводник)
    var ref: DatabaseReference!
//    Создаём массив городов
    var citiesArray = [City]()
    //    Создаём св-во для присвоения предпоследнего запроса города
    var cityBeforeLast: String = ""
    //    Создаём экземпляр класса LoginWeatherView
    var loginWeatherView = LoginWeatherView()
    //    Создаём экземпляр класса DataFetcherService
    let dataFetcherService = DataFetcherService()
    //    Создаём экземпляр класса Animate
    let animate = Animate()
    //    Создаём менеджера, который будет с приставкой lazy. Если пользователь откажет в предоставлении месторасположения, методы не будут находиться в памяти
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        //    Необходимо указать точность с которой мы хотим получать информацию. kCLLocationAccuracyKilometer укзывает на точность в километр
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //        Запрашиваем пользователя к доступу его геопозиции
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    //    Вызывается, чтобы уведомить ViewController о том, что его view собирается разместить свои subviews
    override func viewWillLayoutSubviews() {
    }
    
    //    Экран уже загрузился
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherView.scrollView.panGestureRecognizer.isEnabled = false
        
        //        Добавляем объекты на контроллер
        view.addSubview(weatherView)
        //        Привязываем объекты к родительскому вью
        weatherView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        //        Настраиваем кнопку навигационного контроллера
        navigationController?.setBackButton(with: "Назад")
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        //        Заливаем наше вью в белый цвет
        view.backgroundColor = .white
        //        Ввод текста происходит на английском языке. Метод, который не позволяет открыть клавиатуру на русском
        weatherView.cityTextField.keyboardType = .asciiCapable
        //        Текстовое поле будет в роли делегата
        weatherView.cityTextField.delegate = self
        //        Вызов метода, который обновит интерфейс приложения по полученным данным с сервера
        dataFetcherService.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.weatherView.updateInterfaceWith(weather: currentWeather)
        }
        //        У пользователя может быть отключена настройка геопозиции (общая настройка в телефоне), для этого проверяем locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        //        Добавим таргет к кнопке поиска погоды
        weatherView.searchWeatherButton.addTarget(self, action: #selector(myButtonPressed(_:)), for: .primaryActionTriggered)
        //        Добавляем таргет для перехода на следующий экран
        weatherView.lastCityButton.addTarget(self, action: #selector(lastButtonPressed(_:)), for: .primaryActionTriggered)
    }
    
    //    Экран будет отображён
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        Скрытие навигейшн бара
        self.navigationController?.isNavigationBarHidden = false
        //        Добавим анимацию для картинки с погодными условиями
        animate.animateAnyObjects(animateObject: self.weatherView.weatherIconImageView)
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
    }
    
//    Создаём пользователя
    private func newUser() {
        
//        Необходимо сделать проверку при создании текущего пользователя
        guard let currentUser = Auth.auth().currentUser else { return }
//        Приводим нашего текущего пользователя к Users для получения к нему доступа при необходимости, таким образом мы взяли данные зарегестрированного пользователя и передали в Users, теперь у нас есть доступ к id и email
        user = Users(users: currentUser)
//        Получаем доступ к uid и email
        ref = Database.database().reference(withPath: "users").child(String(user.id)).child("cities")
    }
    
    //    По нажатию на кнопку ввода город с текстового поля будет передан в GET запрос и массив с городами
    @objc private func myButtonPressed(_ sender: UIButton) {
        getCityText { [unowned self] (city) in
            self.dataFetcherService.fetchCurrentWeather(forRequstType: .cityName(city: city))
            //            Сохранение запроса города в памяти и добавление в массив cityArray
            saveCity(nameCity: city)
            //            Обновляем нашу переменную cityBeforeLast
            addCityBeforeLast()
        }
    }
    
    //    Метод по сохранению названия городов в CoreData и массиве cityArray
    private func saveCity(nameCity name: String) {
        
//        Создаём город
        let cities = City(title: name, userID: self.user.id)
//        Указываем расположение задачи на сервере, т.е. создаём референс (ссылку)
        let cityRef = self.ref.child(cities.cityName.lowercased())
//        Указываем по какому ключу что будет
        cityRef.setValue(cities.convertToDictionary())
    }
    
    //    Загрузка города из нашей памяти
    private func loadCity() {

        //        Обновляем нашу переменную cityBeforeLast
        addCityBeforeLast()
    }
    //    Метод, который находит в массиве предпоследний запрос и передаёт его в переменную cityBeforeLast для дальнейшей обработки
    private func addCityBeforeLast() {
        //        Предпоследний порядковый номер массива
        var numberBeforeLast = 0
        
        }
    
    //    По нажатию на кнопку будет переход на следующий экран показывающий текущую погоду по предыдущему запросу
    @objc private func lastButtonPressed(_ sender: UIButton) {
        //        Загружаем данные из CoreData
        //        loadCity()
        //        Достаём второй контроллер
        let secondViewController = SecondViewController()

        //        Совершаем переход на следующий контроллер
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc private func backLoginViewController() {
        do {
            try Firebase.Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        //        Позже нам необходимо, чтоб экран закрылся
        dismiss(animated: true, completion: nil)
    }
}
