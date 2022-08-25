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
    
    //    Основная вьюшка
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    //    Скролл Вью
    private let scrollView = UIScrollView()
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
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Стек для температуры
    private let tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Температура
    private let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "Температура, °C"
        tempLabel.font = UIFont.systemFont(ofSize: 17)
        tempLabel.textColor = UIColor(named: "Text color")
        return tempLabel
    }()
    //    Текущая температура
    private let tempCurrentLabel: UILabel = {
        let tempCurrentLabel = UILabel()
        tempCurrentLabel.text = "23"
        tempCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        tempCurrentLabel.textColor = UIColor(named: "Text color")
        return tempCurrentLabel
    }()
    //    Стек для ощущаемой температуры
    private let feelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Ощущаемая температура
    private let feelsTempLabel: UILabel = {
        let feelsTempLabel = UILabel()
        feelsTempLabel.text = "Ощущается, °C"
        feelsTempLabel.font = UIFont.systemFont(ofSize: 17)
        feelsTempLabel.textColor = UIColor(named: "Text color")
        return feelsTempLabel
    }()
    //    Текущая ощущаемая температура
    private let feelsCurrentTempLabel: UILabel = {
        let feelsCurrentTempLabel = UILabel()
        feelsCurrentTempLabel.text = "25"
        feelsCurrentTempLabel.font = UIFont.systemFont(ofSize: 17)
        feelsCurrentTempLabel.textColor = UIColor(named: "Text color")
        return feelsCurrentTempLabel
    }()
    //    Стек для давления
    private let pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Атмосферное давление
    private let pressureLabel: UILabel = {
        let pressureLabel = UILabel()
        pressureLabel.text = "Давление, гПа"
        pressureLabel.font = UIFont.systemFont(ofSize: 17)
        pressureLabel.textColor = UIColor(named: "Text color")
        return pressureLabel
    }()
    //    Текущее атмосферное давление
    private let pressureCurrentLabel: UILabel = {
        let pressureCurrentLabel = UILabel()
        pressureCurrentLabel.text = "746"
        pressureCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        pressureCurrentLabel.textColor = UIColor(named: "Text color")
        return pressureCurrentLabel
    }()
    //    Стек для ветра
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Скорость ветра
    private let windLabel: UILabel = {
        let windLabel = UILabel()
        windLabel.text = "Скорость ветра, м/с"
        windLabel.font = UIFont.systemFont(ofSize: 17)
        windLabel.textColor = UIColor(named: "Text color")
        return windLabel
    }()
    //    Текущая скорость ветра
    private let windCurrentLabel: UILabel = {
        let windCurrentLabel = UILabel()
        windCurrentLabel.text = "5"
        windCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        windCurrentLabel.textColor = UIColor(named: "Text color")
        return windCurrentLabel
    }()
    //    Стек с влажностью воздуха
    private let humidityStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    //    Влажность воздуха
    private let humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.text = "Влажность воздуха, %"
        humidityLabel.font = UIFont.systemFont(ofSize: 17)
        humidityLabel.textColor = UIColor(named: "Text color")
        return humidityLabel
    }()
    //    Текущая влажность воздуха
    private let currentHumidityLabel: UILabel = {
        let currentHumidityLabel = UILabel()
        currentHumidityLabel.text = "35"
        currentHumidityLabel.font = UIFont.systemFont(ofSize: 17)
        currentHumidityLabel.textColor = UIColor(named: "Text color")
        return currentHumidityLabel
    }()
    //    Описание погоды
    private let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.text = "Описание"
        conditionLabel.font = UIFont.systemFont(ofSize: 17)
        conditionLabel.textColor = UIColor(named: "Text color")
        return conditionLabel
    }()
    //    Стек с рассветом
    private let sunriseStack: UIStackView = {
        let sunriseStack = UIStackView()
        sunriseStack.alignment = .leading
        sunriseStack.spacing = 10
        return sunriseStack
    }()
    //    Рассвет
    private let sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.text = "Рассвет, час:мин:сек"
        sunriseLabel.font = UIFont.systemFont(ofSize: 17)
        sunriseLabel.textColor = UIColor(named: "Text color")
        return sunriseLabel
    }()
    //    Время рассвета
    private let sunriseLabelTime: UILabel = {
        let sunriseLabelTime = UILabel()
        sunriseLabelTime.text = "04:22:31"
        sunriseLabelTime.font = UIFont.systemFont(ofSize: 17)
        sunriseLabelTime.textColor = UIColor(named: "Text color")
        return sunriseLabelTime
    }()
    //    Стек с закатом
    private let sunsetStack: UIStackView = {
        let sunsetStack = UIStackView()
        sunsetStack.alignment = .leading
        sunsetStack.spacing = 10
        return sunsetStack
    }()
    //    Закат
    private let sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        sunsetLabel.text = "Закат, час:мин:сек"
        sunsetLabel.font = UIFont.systemFont(ofSize: 17)
        sunsetLabel.textColor = UIColor(named: "Text color")
        return sunsetLabel
    }()
    //    Время заката
    private let sunsetLabelTime: UILabel = {
        let sunsetLabelTime = UILabel()
        sunsetLabelTime.text = "21:10:15"
        sunsetLabelTime.font = UIFont.systemFont(ofSize: 17)
        sunsetLabelTime.textColor = UIColor(named: "Text color")
        return sunsetLabelTime
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
    private func configureView() {
        
        view.addSubview(scrollView)
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
        tempStackView.addArrangedSubview(tempLabel)
        tempStackView.addArrangedSubview(tempCurrentLabel)
        feelsStackView.addArrangedSubview(feelsTempLabel)
        feelsStackView.addArrangedSubview(feelsCurrentTempLabel)
        pressureStackView.addArrangedSubview(pressureLabel)
        pressureStackView.addArrangedSubview(pressureCurrentLabel)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windCurrentLabel)
        humidityStack.addArrangedSubview(humidityLabel)
        humidityStack.addArrangedSubview(currentHumidityLabel)
        sunriseStack.addArrangedSubview(sunriseLabel)
        sunriseStack.addArrangedSubview(sunriseLabelTime)
        sunsetStack.addArrangedSubview(sunsetLabel)
        sunsetStack.addArrangedSubview(sunsetLabelTime)
        mainStackView.addArrangedSubview(conditionLabel)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(searchWeatherButton)
    }
    
    //    Расположение объектов на экране
    private func makeConstraints() {
        
        //        Скролл
        scrollView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
        }
        //        Фон
        imageView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
            maker.center.equalToSuperview()
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
        tempLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Ощущаемая температура
        feelsTempLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Давление
        pressureLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Скорость ветра
        windLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Рассвет
        sunriseLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Закат
        sunsetLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Описание
        conditionLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
        }
        //        Влажность
        humidityLabel.snp.makeConstraints { (maker) in
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
            self.tempCurrentLabel.text = weather.currentTemperature
            self.feelsCurrentTempLabel.text = weather.currentFeelsTemperature
            self.pressureCurrentLabel.text = weather.currentPressure
            self.windCurrentLabel.text = weather.currentSpeedWind
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
            self.currentHumidityLabel.text = weather.currentHumidity
            self.conditionLabel.text = weather.dictionaryWeather
            self.sunriseLabelTime.text = weather.currentSunrise
            self.sunsetLabelTime.text = weather.currentSunset
        }
    }
}

