//
//  View.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class WeatherView: UIView {
    
    //    Скролл Вью
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    //    Фон экрана
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Afternoon")
        return imageView
    }()
    //    Вьюшка с рисунком обозначающую погоду
    private let weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage.init(systemName: "nosign")
        weatherIconImageView.tintColor = UIColor(named: "Text color")
        return weatherIconImageView
    }()
    //    Главный стек
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Стек для температуры
    private let tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Температура
    private let tempLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "Температура, °C"
        tempLable.font = UIFont.systemFont(ofSize: 17)
        //        tempLable.textColor = UIColor.init(named: "Color")
        tempLable.textColor = UIColor(named: "Text color")
        return tempLable
    }()
    //    Текущая температура
    private let tempCurrentLable: UILabel = {
        let tempLable = UILabel()
        tempLable.text = "23"
        tempLable.font = UIFont.systemFont(ofSize: 17)
        tempLable.textColor = UIColor(named: "Text color")
        return tempLable
    }()
    //    Стек для ощущаемой температуры
    private let feelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Ощущаемая температура
    private let feelsTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "Ощущается, °C"
        feelsTempLable.font = UIFont.systemFont(ofSize: 17)
        feelsTempLable.textColor = UIColor(named: "Text color")
        return feelsTempLable
    }()
    //    Текущая ощущаемая температура
    private let feelsCurrentTempLable: UILabel = {
        let feelsTempLable = UILabel()
        feelsTempLable.text = "25"
        feelsTempLable.font = UIFont.systemFont(ofSize: 17)
        feelsTempLable.textColor = UIColor(named: "Text color")
        return feelsTempLable
    }()
    //    Стек для давления
    private let pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Атмосферное давление
    private let pressureLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "Давление, гПа"
        pressureLable.font = UIFont.systemFont(ofSize: 17)
        pressureLable.textColor = UIColor(named: "Text color")
        return pressureLable
    }()
    //    Текущее атмосферное давление
    private let pressureCurrentLable: UILabel = {
        let pressureLable = UILabel()
        pressureLable.text = "746"
        pressureLable.font = UIFont.systemFont(ofSize: 17)
        pressureLable.textColor = UIColor(named: "Text color")
        return pressureLable
    }()
    //    Стек для ветра
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Скорость ветра
    private let windLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "Скорость ветра, м/с"
        windLable.font = UIFont.systemFont(ofSize: 17)
        windLable.textColor = UIColor(named: "Text color")
        return windLable
    }()
    //    Текущая скорость ветра
    private let windCurrentLable: UILabel = {
        let windLable = UILabel()
        windLable.text = "5"
        windLable.font = UIFont.systemFont(ofSize: 17)
        windLable.textColor = UIColor(named: "Text color")
        return windLable
    }()
    //    Стек с влажностью воздуха
    private let humidityStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Влажность воздуха
    private let humidityLable: UILabel = {
        let humidity = UILabel()
        humidity.text = "Влажность воздуха, %"
        humidity.numberOfLines = 0
        humidity.font = UIFont.systemFont(ofSize: 17)
        humidity.textColor = UIColor(named: "Text color")
        return humidity
    }()
    //    Текущая влажность воздуха
    private let currentHumidityLable: UILabel = {
        let humidity = UILabel()
        humidity.text = "35"
        humidity.numberOfLines = 0
        humidity.font = UIFont.systemFont(ofSize: 17)
        humidity.textColor = UIColor(named: "Text color")
        return humidity
    }()
    //    Описание погоды
    private let condition: UILabel = {
        let condition = UILabel()
        condition.text = "Описание"
        condition.font = UIFont.systemFont(ofSize: 17)
        condition.textColor = UIColor(named: "Text color")
        return condition
    }()
    //    Стек с рассветом
    private let sunriseStack: UIStackView = {
        let sunriseStack = UIStackView()
        sunriseStack.axis = .horizontal
        sunriseStack.distribution = .fill
        sunriseStack.alignment = .leading
        sunriseStack.spacing = 10
        return sunriseStack
    }()
    //    Рассвет
    private let sunriseLable: UILabel = {
        let sunriseLable = UILabel()
        sunriseLable.text = "Рассвет, час:мин:сек"
        sunriseLable.numberOfLines = 0
        sunriseLable.font = UIFont.systemFont(ofSize: 17)
        sunriseLable.textColor = UIColor(named: "Text color")
        return sunriseLable
    }()
    //    Время рассвета
    private let sunriseLableTime: UILabel = {
        let sunriseLableTime = UILabel()
        sunriseLableTime.text = "04:22:31"
        sunriseLableTime.numberOfLines = 0
        sunriseLableTime.font = UIFont.systemFont(ofSize: 17)
        sunriseLableTime.textColor = UIColor(named: "Text color")
        return sunriseLableTime
    }()
    //    Стек с закатом
    private let sunsetStack: UIStackView = {
        let sunsetStack = UIStackView()
        sunsetStack.axis = .horizontal
        sunsetStack.distribution = .fill
        sunsetStack.alignment = .leading
        sunsetStack.spacing = 10
        return sunsetStack
    }()
    //    Закат
    private let sunsetLable: UILabel = {
        let sunsetLable = UILabel()
        sunsetLable.text = "Закат, час:мин:сек"
        sunsetLable.numberOfLines = 0
        sunsetLable.font = UIFont.systemFont(ofSize: 17)
        sunsetLable.textColor = UIColor(named: "Text color")
        return sunsetLable
    }()
    //    Время заката
    private let sunsetLableTime: UILabel = {
        let sunsetLableTime = UILabel()
        sunsetLableTime.text = "21:10:15"
        sunsetLableTime.numberOfLines = 0
        sunsetLableTime.font = UIFont.systemFont(ofSize: 17)
        sunsetLableTime.textColor = UIColor(named: "Text color")
        return sunsetLableTime
    }()
    //    Поле для ввода города
    private let cityTextField: UITextField = {
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
    let searchWeatherButton: UIButton = {
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
    
//    Создаём инициализатор для отображения методов
    init() {
        super.init(frame: .zero)
        
//        Отображение объектов
        configureView()
//        Размещение объектов на экране
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    Добавление объектов на экран
    func configureView() {
        
        //        view.addSubview(scrollView)
        //        view.backgroundColor = .white
        scrollView.addSubview(imageView)
        scrollView.addSubview(weatherIconImageView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(tempStackView)
        mainStackView.addArrangedSubview(feelsStackView)
        mainStackView.addArrangedSubview(pressureStackView)
        mainStackView.addArrangedSubview(windStackView)
        mainStackView.addArrangedSubview(humidityStack)
        mainStackView.addArrangedSubview(sunriseStack)
        mainStackView.addArrangedSubview(sunsetStack)
        tempStackView.addArrangedSubview(tempLable)
        tempStackView.addArrangedSubview(tempCurrentLable)
        feelsStackView.addArrangedSubview(feelsTempLable)
        feelsStackView.addArrangedSubview(feelsCurrentTempLable)
        pressureStackView.addArrangedSubview(pressureLable)
        pressureStackView.addArrangedSubview(pressureCurrentLable)
        windStackView.addArrangedSubview(windLable)
        windStackView.addArrangedSubview(windCurrentLable)
        humidityStack.addArrangedSubview(humidityLable)
        humidityStack.addArrangedSubview(currentHumidityLable)
        sunriseStack.addArrangedSubview(sunriseLable)
        sunriseStack.addArrangedSubview(sunriseLableTime)
        sunsetStack.addArrangedSubview(sunsetLable)
        sunsetStack.addArrangedSubview(sunsetLableTime)
        mainStackView.addArrangedSubview(condition)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(searchWeatherButton)
    }
    
    //    Расположение объектов на экране
    func makeConstraints() {
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
    
    //    Обновление интерфейса приложения
    func updateInterfaceWith(weather: CurrentWeather) {
        
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

