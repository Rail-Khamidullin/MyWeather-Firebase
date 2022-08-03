//
//  View.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class ObjectWeatherView {
    
    //    Скролл Вью
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    //    Фон экрана
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Afternoon")
        return imageView
    }()
    //    Вьюшка с рисунком обозначающую погоду
    var weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage.init(systemName: "nosign")
        weatherIconImageView.tintColor = UIColor(named: "Text color")
        return weatherIconImageView
    }()
    //    Главный стек
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Стек для температуры
    var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Температура
    var tempLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "Температура, °C"
        tempLable.font = UIFont.systemFont(ofSize: 17)
//        tempLable.textColor = UIColor.init(named: "Color")
        tempLable.textColor = UIColor(named: "Text color")
        return tempLable
    }()
    //    Текущая температура
    var tempCurrentLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "23"
        tempLable.font = UIFont.systemFont(ofSize: 17)
        tempLable.textColor = UIColor(named: "Text color")
        return tempLable
    }()
    //    Стек для ощущаемой температуры
    var feelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Ощущаемая температура
    var feelsTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "Ощущается, °C"
        feelsTempLable.font = UIFont.systemFont(ofSize: 17)
        feelsTempLable.textColor = UIColor(named: "Text color")
        return feelsTempLable
    }()
    //    Текущая ощущаемая температура
    var feelsCurrentTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "25"
        feelsTempLable.font = UIFont.systemFont(ofSize: 17)
        feelsTempLable.textColor = UIColor(named: "Text color")
        return feelsTempLable
    }()
    //    Стек для давления
    var pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Атмосферное давление
    var pressureLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "Давление, гПа"
        pressureLable.font = UIFont.systemFont(ofSize: 17)
        pressureLable.textColor = UIColor(named: "Text color")
        return pressureLable
    }()
    //    Текущее атмосферное давление
    var pressureCurrentLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "746"
        pressureLable.font = UIFont.systemFont(ofSize: 17)
        pressureLable.textColor = UIColor(named: "Text color")
        return pressureLable
    }()
    //    Стек для ветра
    var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Скорость ветра
    var windLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "Скорость ветра, м/с"
        windLable.font = UIFont.systemFont(ofSize: 17)
        windLable.textColor = UIColor(named: "Text color")
        return windLable
    }()
    //    Текущая скорость ветра
    var windCurrentLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "5"
        windLable.font = UIFont.systemFont(ofSize: 17)
        windLable.textColor = UIColor(named: "Text color")
        return windLable
    }()
    //    Стек с влажностью воздуха
    var humidityStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Влажность воздуха
    var humidityLable: UILabel = {
        let humidity = UILabel()
        humidity.text = "Влажность воздуха, %"
        humidity.numberOfLines = 0
        humidity.font = UIFont.systemFont(ofSize: 17)
        humidity.textColor = UIColor(named: "Text color")
        return humidity
    }()
    //    Текущая влажность воздуха
    var currentHumidityLable: UILabel = {
        let humidity = UILabel()
        humidity.text = "35"
        humidity.numberOfLines = 0
        humidity.font = UIFont.systemFont(ofSize: 17)
        humidity.textColor = UIColor(named: "Text color")
        return humidity
    }()
    //    Описание погоды
    var condition: UILabel = {
        let condition = UILabel()
        condition.text = "Описание"
        condition.font = UIFont.systemFont(ofSize: 17)
        condition.textColor = UIColor(named: "Text color")
        return condition
    }()
    //    Стек с рассветом
    var sunriseStack: UIStackView = {
        let sunriseStack = UIStackView()
        sunriseStack.axis = .horizontal
        sunriseStack.distribution = .fill
        sunriseStack.alignment = .leading
        sunriseStack.spacing = 10
        return sunriseStack
    }()
    //    Рассвет
    var sunriseLable: UILabel = {
        let sunriseLable = UILabel()
        sunriseLable.text = "Рассвет, час:мин:сек"
        sunriseLable.numberOfLines = 0
        sunriseLable.font = UIFont.systemFont(ofSize: 17)
        sunriseLable.textColor = UIColor(named: "Text color")
        return sunriseLable
    }()
    //    Время рассвета
    var sunriseLableTime: UILabel = {
        let sunriseLableTime = UILabel()
        sunriseLableTime.text = "04:22:31"
        sunriseLableTime.numberOfLines = 0
        sunriseLableTime.font = UIFont.systemFont(ofSize: 17)
        sunriseLableTime.textColor = UIColor(named: "Text color")
        return sunriseLableTime
    }()
    //    Стек с закатом
    var sunsetStack: UIStackView = {
        let sunsetStack = UIStackView()
        sunsetStack.axis = .horizontal
        sunsetStack.distribution = .fill
        sunsetStack.alignment = .leading
        sunsetStack.spacing = 10
        return sunsetStack
    }()
    //    Закат
    var sunsetLable: UILabel = {
        let sunsetLable = UILabel()
        sunsetLable.text = "Закат, час:мин:сек"
        sunsetLable.numberOfLines = 0
        sunsetLable.font = UIFont.systemFont(ofSize: 17)
        sunsetLable.textColor = UIColor(named: "Text color")
        return sunsetLable
    }()
    //    Время заката
    var sunsetLableTime: UILabel = {
        let sunsetLableTime = UILabel()
        sunsetLableTime.text = "21:10:15"
        sunsetLableTime.numberOfLines = 0
        sunsetLableTime.font = UIFont.systemFont(ofSize: 17)
        sunsetLableTime.textColor = UIColor(named: "Text color")
        return sunsetLableTime
    }()
    //    Поле для ввода города
    var cityTextField: UITextField = {
        let cityTextField = UITextField()
        cityTextField.placeholder = "Введите город"
        cityTextField.textAlignment = .center
        cityTextField.font = UIFont.systemFont(ofSize: 17)
        cityTextField.backgroundColor = .white
        cityTextField.textColor = .init(red: 0.4, green: 0.4, blue: 0.45, alpha: 1)
        cityTextField.layer.borderWidth = 2
        cityTextField.layer.borderColor = UIColor.systemGray6.cgColor
        cityTextField.layer.cornerRadius = 10
        return cityTextField
    }()
    //    Кнопка поиска погоды
    var searchWeatherButton: UIButton = {
        let searchWeatherButton = UIButton(type: .system)
        searchWeatherButton.setTitle("Поиск", for: [])
        searchWeatherButton.titleLabel?.font = .systemFont(ofSize: 16)
        searchWeatherButton.backgroundColor = .white
        searchWeatherButton.tintColor = .init(red: 0.4, green: 0.4, blue: 0.45, alpha: 1)
        searchWeatherButton.layer.borderWidth = 1
        searchWeatherButton.layer.borderColor = UIColor.blue.cgColor
        searchWeatherButton.layer.cornerRadius = 10
        return searchWeatherButton
    }()
}

