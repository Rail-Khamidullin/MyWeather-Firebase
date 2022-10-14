//
//  LastWeatherViewController.swift
//  MyWeather
//
//  Created by Rail on 14.10.2022.
//

import Foundation
import SnapKit

//   Второй контроллер для отображение текущих погодных условий для предыдущего запроса
class LastWeatherViewController: UIViewController {
    
    //    Название города приходящего с первого контроллера
    var nameCity: String = "Город"
    //    Инициализируем WeatherViewSC
    var lastWeatherView = LastWeatherView()
    //    Создаём экземпляр структуры с анимацией
    let animate = Animator()
    //    Создаём экземпляр с запросом погоды
    let dataFetcherServiceSC = DataFetcherServiceSC()
    
    //    Экран будет отображён
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //    Экран уже загрузился
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Присваиваем заголовок с названием города в навигейшн бар
        self.title = "\(nameCity)"
        //        Заливаем наше вью в белый цвет
        view.backgroundColor = .white
        //        Добавление объектов на экран
        view.addSubview(lastWeatherView)
        //        Привязка объектов к родительскому вью
        lastWeatherView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        //        Передаём город в метод запроса погоды
        dataFetcherServiceSC.fetchCurrentWeatherSC(forCity: nameCity)
        //        Обновлениие интерфейса по новым данным
        dataFetcherServiceSC.onCompletionSC = { [weak self] currentWeather in
            guard let self = self else { return }
            self.weatherViewSC.updateInterfaceWith(weather: currentWeather)
        }
        //        Анимация для иконки с погодными условиями
        animate.animateAnyObjects(animateObject: lastWeatherView.weatherIconImageView)
    }
}
