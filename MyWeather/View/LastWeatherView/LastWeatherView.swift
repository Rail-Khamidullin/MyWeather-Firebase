//
//  LastWeatherView.swift
//  MyWeather
//
//  Created by Rail on 14.10.2022.
//

import Foundation
import UIKit
import SnapKit

//   ОБъекты контроллера с отображением предыдущего запроса
final class LastWeatherView: UIView {
    
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
    let weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage(systemName: "nosign")
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
        stackView.distribution = .fill
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
        tempCurrentLabel.text = " "
        tempCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        tempCurrentLabel.textColor = UIColor(named: "Text color")
        return tempCurrentLabel
    }()
    //    Стек для ощущаемой температуры
    private let feelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
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
        feelsCurrentTempLabel.text = " "
        feelsCurrentTempLabel.font = UIFont.systemFont(ofSize: 17)
        feelsCurrentTempLabel.textColor = UIColor(named: "Text color")
        return feelsCurrentTempLabel
    }()
    //    Стек для давления
    private let pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
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
        pressureCurrentLabel.text = " "
        pressureCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        pressureCurrentLabel.textColor = UIColor(named: "Text color")
        return pressureCurrentLabel
    }()
    //    Стек для ветра
    private let windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
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
        windCurrentLabel.text = " "
        windCurrentLabel.font = UIFont.systemFont(ofSize: 17)
        windCurrentLabel.textColor = UIColor(named: "Text color")
        return windCurrentLabel
    }()
    //    Стек с влажностью воздуха
    private let humidityStackView: UIStackView = {
        let humidityStackView = UIStackView()
        humidityStackView.distribution = .fill
        humidityStackView.alignment = .leading
        humidityStackView.spacing = 10
        return humidityStackView
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
        currentHumidityLabel.text = " "
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
    private let sunriseStackView: UIStackView = {
        let sunriseStackView = UIStackView()
        sunriseStackView.distribution = .fill
        sunriseStackView.alignment = .leading
        sunriseStackView.spacing = 10
        return sunriseStackView
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
    private let sunriseTimeLabel: UILabel = {
        let sunriseTimeLabel = UILabel()
        sunriseTimeLabel.text = " "
        sunriseTimeLabel.font = UIFont.systemFont(ofSize: 17)
        sunriseTimeLabel.textColor = UIColor(named: "Text color")
        return sunriseTimeLabel
    }()
    //    Стек с закатом
    private let sunsetStackView: UIStackView = {
        let sunsetStackView = UIStackView()
        sunsetStackView.distribution = .fill
        sunsetStackView.alignment = .leading
        sunsetStackView.spacing = 10
        return sunsetStackView
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
    private let sunsetTimeLabel: UILabel = {
        let sunsetTimeLabel = UILabel()
        sunsetTimeLabel.text = " "
        sunsetTimeLabel.font = UIFont.systemFont(ofSize: 17)
        sunsetTimeLabel.textColor = UIColor(named: "Text color")
        return sunsetTimeLabel
    }()
    
    init() {
        super.init(frame: .zero)
        //        Добавляем объекты на экран
        configureView()
        //        Привязываем объекты между собой и супервью
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    Добавляем объекты на экран
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
    }
    //    Привязываем объекты между собой и супервью
    private func makeConstraints() {
        
        //        Скролл
        scrollView.snp.makeConstraints { (maker) in
            maker.bottom.height.width.equalToSuperview()
            maker.center.equalToSuperview()
            maker.top.equalTo(44)
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
            maker.height.width.equalTo(120)
        }
        //        Главный стек
        mainStackView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(10)
            maker.top.equalTo(weatherIconImageView.snp.bottom).offset(5)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(238)
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
        //        Влажность
        humidityLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        sunriseLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        sunsetLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(200)
        }
        //        Описание
        conditionLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
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
            self.sunriseTimeLabel.text = weather.currentSunrise
            self.sunsetTimeLabel.text = weather.currentSunset
        }
    }
}
