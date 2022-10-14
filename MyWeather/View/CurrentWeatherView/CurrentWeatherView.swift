//
//  View.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
    
    //    Скролл Вью
    let scrollView: UIScrollView = {
       var scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
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
    let weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage(systemName: "nosign")
        weatherIconImageView.tintColor = UIColor(named: "Text color")
        return weatherIconImageView
    }()
    //    Главный стек
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.spacing = 10
        return mainStackView
    }()
    //    Стек для температуры
    private let tempStackView: UIStackView = {
        let tempStackView = UIStackView()
        tempStackView.alignment = .leading
        tempStackView.spacing = 10
        return tempStackView
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
        let feelsStackView = UIStackView()
        feelsStackView.alignment = .leading
        feelsStackView.spacing = 10
        return feelsStackView
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
        let pressureStackView = UIStackView()
        pressureStackView.alignment = .leading
        pressureStackView.spacing = 10
        return pressureStackView
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
        let windStackView = UIStackView()
        windStackView.alignment = .leading
        windStackView.spacing = 10
        return windStackView
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
    private let humidityStackView: UIStackView = {
        let humidityStackView = UIStackView()
        humidityStackView.alignment = .leading
        humidityStackView.spacing = 10
        return humidityStackView
    }()
    //    Влажность воздуха
    private let humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.text = "Влажность воздуха, %"
        humidityLabel.font = UIFont.systemFont(ofSize: 16)
        humidityLabel.textColor = UIColor(named: "Text color")
        return humidityLabel
    }()
    //    Текущая влажность воздуха
    private let currentHumidityLabel: UILabel = {
        let currentHumidityLabel = UILabel()
        currentHumidityLabel.text = "35"
        currentHumidityLabel.font = UIFont.systemFont(ofSize: 16)
        currentHumidityLabel.textColor = UIColor(named: "Text color")
        return currentHumidityLabel
    }()
    //    Описание погоды
    private let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.text = "Описание"
        conditionLabel.font = UIFont.systemFont(ofSize: 16)
        conditionLabel.textColor = UIColor(named: "Text color")
        return conditionLabel
    }()
    //    Стек с рассветом
    private let sunriseStackView: UIStackView = {
        let sunriseStackView = UIStackView()
        sunriseStackView.alignment = .leading
        sunriseStackView.spacing = 10
        return sunriseStackView
    }()
    //    Рассвет
    private let sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.text = "Рассвет, час:мин:сек"
        sunriseLabel.font = UIFont.systemFont(ofSize: 16)
        sunriseLabel.textColor = UIColor(named: "Text color")
        return sunriseLabel
    }()
    //    Время рассвета
    private let sunriseTimeLabel: UILabel = {
        let sunriseTimeLabel = UILabel()
        sunriseTimeLabel.text = "04:22:31"
        sunriseTimeLabel.font = UIFont.systemFont(ofSize: 16)
        sunriseTimeLabel.textColor = UIColor(named: "Text color")
        return sunriseTimeLabel
    }()
    //    Стек с закатом
    private let sunsetStackView: UIStackView = {
        let sunsetStackView = UIStackView()
        sunsetStackView.alignment = .leading
        sunsetStackView.spacing = 10
        return sunsetStackView
    }()
    //    Закат
    private let sunsetLabel: UILabel = {
        let sunsetLabel = UILabel()
        sunsetLabel.text = "Закат, час:мин:сек"
        sunsetLabel.font = UIFont.systemFont(ofSize: 16)
        sunsetLabel.textColor = UIColor(named: "Text color")
        return sunsetLabel
    }()
    //    Время заката
    private let sunsetTimeLabel: UILabel = {
        let sunsetTimeLabel = UILabel()
        sunsetTimeLabel.text = "21:10:15"
        sunsetTimeLabel.font = UIFont.systemFont(ofSize: 16)
        sunsetTimeLabel.textColor = UIColor(named: "Text color")
        return sunsetTimeLabel
    }()
    //    Поле для ввода города
    let cityTextField: UITextField = {
        let cityTextField = UITextField()
        cityTextField.placeholder = "Введите город"
        cityTextField.textAlignment = .center
        cityTextField.font = UIFont.systemFont(ofSize: 16)
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
    //    Кнопка для перехода на экран с предыдущим запросом
    let lastCityButton: UIButton = {
        let lastCityButton = UIButton(type: .system)
        lastCityButton.setTitle("Предыдущий запрос", for: [])
        lastCityButton.titleLabel?.font = .systemFont(ofSize: 16)
        lastCityButton.backgroundColor = .white
        lastCityButton.tintColor = .init(red: 0.4, green: 0.4, blue: 0.45, alpha: 1)
        lastCityButton.layer.borderWidth = 1
        lastCityButton.layer.borderColor = UIColor.blue.cgColor
        lastCityButton.layer.cornerRadius = 10
        return lastCityButton
    }()
    //    Создаём инициализатор для отображения методов
    init() {
        super.init(frame: .zero)
        
        //        Отображение объектов
        configureView()
        //        Размещение объектов на экране
        makeConstraints()
    }
    
    //    Обязательный инициализатор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    Добавление объектов на экран
    private func configureView() {
        
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(weatherIconImageView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(tempStackView)
        mainStackView.addArrangedSubview(feelsStackView)
        mainStackView.addArrangedSubview(pressureStackView)
        mainStackView.addArrangedSubview(windStackView)
        mainStackView.addArrangedSubview(humidityStackView)
        mainStackView.addArrangedSubview(sunriseStackView)
        mainStackView.addArrangedSubview(sunsetStackView)
        tempStackView.addArrangedSubview(tempLabel)
        tempStackView.addArrangedSubview(tempCurrentLabel)
        feelsStackView.addArrangedSubview(feelsTempLabel)
        feelsStackView.addArrangedSubview(feelsCurrentTempLabel)
        pressureStackView.addArrangedSubview(pressureLabel)
        pressureStackView.addArrangedSubview(pressureCurrentLabel)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windCurrentLabel)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(currentHumidityLabel)
        sunriseStackView.addArrangedSubview(sunriseLabel)
        sunriseStackView.addArrangedSubview(sunriseTimeLabel)
        sunsetStackView.addArrangedSubview(sunsetLabel)
        sunsetStackView.addArrangedSubview(sunsetTimeLabel)
        mainStackView.addArrangedSubview(conditionLabel)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(searchWeatherButton)
        scrollView.addSubview(lastCityButton)
    }
    
    //    Расположение объектов на экране
    private func makeConstraints() {
        
        //        Скролл
        scrollView.snp.makeConstraints { (maker) in
            maker.bottom.height.width.equalToSuperview()
            maker.top.equalTo(44)
        }
        //        Фон
        imageView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
            maker.center.equalToSuperview()
            maker.height.greaterThanOrEqualTo(520)
        }
        //        Иконка с погодой
        weatherIconImageView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(10)
            maker.centerX.equalToSuperview()
            maker.height.width.equalTo(115)
        }
        //        Главный стек
        mainStackView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(10)
            maker.top.equalTo(weatherIconImageView.snp.bottom).offset(0)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(226)
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
            maker.top.equalTo(mainStackView.snp.bottom).offset(15)
        }
        //        Кнопка поиска погоды
        searchWeatherButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(cityTextField.snp.bottom).offset(15)
            maker.width.equalTo(200)
            maker.height.equalTo(30)
            maker.centerX.equalToSuperview()
        }
        //        Кнопка перехода на другой контроллер
        lastCityButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(searchWeatherButton.snp.bottom).offset(15)
            maker.width.equalTo(200)
            maker.height.equalTo(30)
            maker.centerX.equalToSuperview()
        }
    }
    
    //    Обновление интерфейса приложения
    func updateInterfaceWith(weather: CurrentWeather) {
        //        Асинхронно через гланую очередь
        DispatchQueue.main.async {
            self.tempCurrentLabel.text = weather.currentTemperature
            self.feelsCurrentTempLabel.text = weather.currentFeelsTemperature
            self.pressureCurrentLabel.text = weather.currentPressure
            self.windCurrentLabel.text = weather.currentSpeedWind
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
            self.currentHumidityLabel.text = weather.currentHumidity
            self.conditionLabel.text = weather.dictionaryWeather
            self.sunriseTimeLabel.text = weather.currentSunrise
            self.sunsetTimeLabel.text = weather.currentSunset
        }
    }
}

