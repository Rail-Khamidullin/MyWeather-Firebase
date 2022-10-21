//
//  ExtensionLoginView.swift
//  MyWeather
//
//  Created by Rail on 17.10.2022.
//

import UIKit

extension LoginWeatherViewController {
    
    //    Метод для открытия и скрытия клавиатуры по нажатию на кнопку return или экран
    func tapGester() {
        //        Скрытие клавиатуры по нажатию на экран
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tapGesterRecognizer)
        //        Скрытие клавиатуры по нажатию на кнопку ввод
        loginWeatherView.emailTextField.addTarget(self, action: #selector(keyboardWillHide), for: .primaryActionTriggered)
        loginWeatherView.passwordTextField.addTarget(self, action: #selector(keyboardWillHide), for: .primaryActionTriggered)
    }
    //    Получение данных по клавиатуре
    func connectToNotificationCenter() {
        ///        Обращаемся к центру объявлений -> через наблюдатель addObserver
        //        Показать клавиатуру
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        //        Скрыть клавиатуру
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    //     Открытие клавиатуры с поднятием текстового поля на высоту клавиатуры + 5 пойнтов
    @objc private func keyboardDidShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHight = keyboardFrame.height + 5
        
        loginWeatherView.scrollView.contentInset.bottom = keyboardHight
    }
    //    Скрытие клавиатуры
    @objc private func keyboardWillHide() {
        loginWeatherView.scrollView.contentInset.bottom = 0
        //        Конец редактирования
        view.endEditing(true)
    }
}


