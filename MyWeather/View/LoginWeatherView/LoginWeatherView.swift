//
//  LoginWeatherView.swift
//  MyWeather
//
//  Created by Rail on 17.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class LoginWeatherView: UIView {
    //    Скролл вью
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemTeal
        scrollView.contentSize = .zero
        return scrollView
    }()
    //    Стек вью, который будет содержать все объекты
    private let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        return mainStackView
    }()
    //    Стек вью, который будет содержать все объекты
    private let infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.alignment = .center
        infoStackView.axis = .vertical
        infoStackView.spacing = 20
        return infoStackView
    }()
    //    Лейбл с названием приложения
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "My Weather"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        //        titleLabel.font = UIFont(name: "Tamil Sangam MN 40.0", size: 30)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    //    Лейбл с предупреждением в случае не правильного ввода пароля, логина и др.
    let warnLabel: UILabel = {
        let warnLabel = UILabel()
        warnLabel.text = "Здесь будет выводиться ошибка"
        warnLabel.textColor = .red
        warnLabel.font = UIFont.systemFont(ofSize: 18)
        warnLabel.alpha = 0
        warnLabel.numberOfLines = 0
        warnLabel.textAlignment = .center
        return warnLabel
    }()
    //    Стек вью для текстовых полей ввода почты и пароля
    private let registerStackView: UIStackView = {
        let registerStackView = UIStackView()
        registerStackView.alignment = .center
        registerStackView.axis = .vertical
        registerStackView.spacing = 10
        return registerStackView
    }()
    //    Текстовое поле для воода адреса электронной почты
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = " Email"
        emailTextField.backgroundColor = .white
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.layer.cornerRadius = 4
        return emailTextField
    }()
    //    Текстовое поле для ввода пароля
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = " Пароль"
        passwordTextField.backgroundColor = .white
        passwordTextField.font = UIFont.systemFont(ofSize: 18)
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    //    Стек вью для кнопок входа и регистрации
    private let buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.alignment = .center
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        return buttonStackView
    }()
    //    Кнопка входа в приложение
    let loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Войти", for: [])
        loginButton.titleLabel?.font = .systemFont(ofSize: 20)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 2
        return loginButton
    }()
    //    Кнопка регистрации в приложении
    let registrationButton: UIButton = {
        let registrationButton = UIButton(type: .system)
        registrationButton.setTitle("Регистрация", for: [])
        registrationButton.titleLabel?.font = .systemFont(ofSize: 20)
        registrationButton.tintColor = .white
        registrationButton.layer.cornerRadius = 5
        registrationButton.layer.borderColor = UIColor.white.cgColor
        registrationButton.layer.borderWidth = 2
        return registrationButton
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
        scrollView.addSubview(mainStackView)
        mainStackView.addSubview(infoStackView)
        mainStackView.addSubview(registerStackView)
        mainStackView.addSubview(buttonStackView)
        infoStackView.addSubview(titleLabel)
        infoStackView.addSubview(warnLabel)
        registerStackView.addSubview(emailTextField)
        registerStackView.addSubview(passwordTextField)
        buttonStackView.addSubview(loginButton)
        buttonStackView.addSubview(registrationButton)
    }
    
    //    Привязываем объекты между собой и супервью
    private func makeConstraints() {
        //        Скрол
        scrollView.snp.makeConstraints { (maker) in
            maker.top.left.right.bottom.equalToSuperview()
        }
        //        Главный стек
        mainStackView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview().inset(40)
            maker.center.equalToSuperview()
        }
        //        Стек с названием приложения и выводом предупреждения
        infoStackView.snp.makeConstraints { (maker) in
            maker.left.right.top.equalToSuperview()
            maker.height.equalTo(105)
        }
        //        Стек с полями для ввода электронной почты и пароля
        registerStackView.snp.makeConstraints { (maker) in
            maker.top.equalTo(infoStackView.snp.bottom).offset(40)
            maker.left.right.equalToSuperview()
            maker.height.equalTo(80)
        }
        //        Стек с кнопками для входа и регистрации
        buttonStackView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(registerStackView.snp.bottom).offset(40)
            maker.height.equalTo(82)
        }
        //        Название приложения
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.right.top.equalToSuperview()
        }
        //        Лейбл с выводом предупреждения
        warnLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        //        Поля для ввода почты
        emailTextField.snp.makeConstraints { (maker) in
            maker.left.right.top.equalToSuperview()
        }
        //        Поле для ввода пароля
        passwordTextField.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
        //        Кнопка входа в приложение
        loginButton.snp.makeConstraints { (maker) in
            maker.left.right.top.equalToSuperview()
        }
        //        Кнопка регистрации в приложении
        registrationButton.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(loginButton.snp.bottom).offset(10)
        }
    }
}
