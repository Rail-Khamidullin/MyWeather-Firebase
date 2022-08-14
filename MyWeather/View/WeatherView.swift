//
//  WeatherView.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import Foundation
import UIKit
import SnapKit

//   Класс со свойствами для объектов. Все объекты можно переиспользовать
final class WeatherView {
    
    //    Фон экрана
    func imageView(imageView: UIImageView) {
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "Afternoon")
    }
//    Вьюшка с рисунком обозначающую погоду
    func weatherIconImageView(iconImage: UIImageView) {
        iconImage.image = UIImage(systemName: "nosign")
        iconImage.tintColor = UIColor(named: "Text color")
    }
//    Главный стек
    func mainStackView(stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
    }
//    Универсальный стек для: температуры, ощущаемой температуры, давления, влажности, скорости ветра, времени рассвета и заката
    func weatherStackView(stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
    }
//    Универсальный лейбл для всех объектов
    func weatherLable(lable: UILabel, text: String) {
        lable.text = text
        lable.font = UIFont.systemFont(ofSize: 17)
        lable.textColor = UIColor(named: "Text color")
    }
//    Текстовое поле для ввода названия города
    func cityTextField(textField: UITextField) {
        textField.placeholder = "Введите город"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.backgroundColor = .white
        textField.textColor = .init(red: 0.4, green: 0.4, blue: 0.45, alpha: 1)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray6.cgColor
        textField.layer.cornerRadius = 10
    }
//    Кнопка поиска города
    func searchWeatherButton(button: UIButton) {
        button.setTitle("Поиск", for: [])
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.tintColor = .init(red: 0.4, green: 0.4, blue: 0.45, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 10
    }
}

