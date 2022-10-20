//
//  LoginWeatherViewController.swift
//  MyWeather
//
//  Created by Rail on 17.10.2022.
//

import UIKit
import SnapKit
import Firebase

class LoginWeatherViewController: UIViewController {
    
    //    Экземпляр класса с нашими view
    let loginWeatherView = LoginWeatherView()
    //    Создаём путь к нахождению данных
    var ref: DatabaseReference!
    //    Создаём экземпляр класса с Анимацией объектов
    let animator = Animator()
    
    //    Приложение будет отображено
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        Убираем заполненные ранее текстовые поля
        loginWeatherView.emailTextField.text = ""
        loginWeatherView.passwordTextField.text = ""
        //        Убираем навигейшн бар
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        Добавляем view на экран
        view.addSubview(loginWeatherView)
        //        Устанавливаем констрейнты для view
        loginWeatherView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        //        Создаём доступ через путь "users"
        ref = Database.database().reference(withPath: "users")
        //        Фон вью
        view.backgroundColor = .white
        //        Метод для открытия и скрытия клавиатуры
        tapGester()
        //        Получение данных по клавиатуре
        connectToNotificationCenter()
        //        Устанавливаем логику входа в приложение через нажатие кнопки входа
        loginWeatherView.loginButton.addTarget(self, action: #selector(loginTapped), for: .primaryActionTriggered)
        //        Устанавливаем логику регистрации в приложении
        loginWeatherView.registrationButton.addTarget(self, action: #selector(registerTapped), for: .primaryActionTriggered)
        //        Проверяем изменился ли пользователь и его данные
        //                verification()
        //        Настраиваем кнопку навигационного контроллера
        navigationController?.setBackButton(with: "Назад")
    }
    
    //    Вывод предупреждений
    private func displayWarningLable(withText text: String) {
        //        Присваиваем текст нашем предупреждающему лейблу
        loginWeatherView.warnLabel.text = text
        //        Создаём анимацию для warnLable
        animator.loseAnyObject(animateObject: loginWeatherView.warnLabel)
    }
    
    //    Метод ввода имени и пароля для входа в приложение
    @objc private func loginTapped() {
        //        Для регистрации необходимо ввести адрес почты и пароль, проверяем наличие
        guard let email = loginWeatherView.emailTextField.text, let password = loginWeatherView.passwordTextField.text,
              email != "", password != "" else {
            //            Если условия не выполнены, то выходит ошибка
            displayWarningLable(withText: "Заполните пожалуйста данные")
            return
        }
        
        //                Если текст ввели, то проверяем наличие зарегистрированного пользователя
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            
            if error != nil {
                //        Если имеется ошибка при вводе текста, то в предупреждающий Лейбл через метод displayWarningLable выводим текст ошибки
                self?.displayWarningLable(withText: "Не правильный пароль или логин")
                return
            }
            //                    Необходимо проеверить существует ли пользователь с таким логином и паролем
            if user != nil {
                //                        Если да, то переходим на другой контроллер
                //                        Создаём экземпляр класса FirstViewController
                let currentWeatherViewController = CurrentWeatherViewController()
                //                        Совершаем переход
                self?.navigationController?.pushViewController(currentWeatherViewController, animated: true)
                return
            }
            //                    Если пользователя такого нет
            self?.displayWarningLable(withText: "Такого пользователя нет.")
        }
    }
    
    //        Проверяем изменился ли пользователь и его данные
    private func verification() {
        
        Firebase.Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                //                        Создаём экземпляр класса CurrentWeatherViewController
                let сurrentWeatherViewController = CurrentWeatherViewController()
                //                        Совершаем переход
                self?.navigationController?.pushViewController(сurrentWeatherViewController, animated: true)
            }
        }
    }
    
    //    Метод для регистрации пользователя в приложении
    @objc private func registerTapped() {
        //        Для регистрации необходимо ввести адрес почты и пароль, проверяем наличие
        guard let email = loginWeatherView.emailTextField.text, let password = loginWeatherView.passwordTextField.text,
              email != "", password != "" else {
            //            Если условия не выполнены, то выходит ошибка
            displayWarningLable(withText: "Информация не корректна")
            return
        }
        //        Создаём пользователя
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            
            //            Проверяем наличие записей
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                self?.displayWarningLable(withText: error?.localizedDescription as! String)
                return
            }
            //            Создаём пользователя
            let userRef = self?.ref.child((user?.user.uid)!)
            //            Добавляем в массив значение по ключу email
            userRef?.setValue(["email": user?.user.email])
            //            Достаём доступ до FirstViewController
            let currentWeatherViewController = CurrentWeatherViewController()
            //                        Совершаем переход
            self?.navigationController?.pushViewController(currentWeatherViewController, animated: true)
        }
    }
}
