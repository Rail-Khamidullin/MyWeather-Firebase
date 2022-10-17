//
//  AppDelegate.swift
//  MyWeather
//
//  Created by Rail on 30.05.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let loginWeatherViewController = LoginWeatherViewController()
        let currentWeatherViewController = CurrentWeatherViewController()
        //        Достаём window для дальнейшего отображения контроллера
        window = UIWindow(frame: UIScreen.main.bounds)
        //        Указываем с какого контроллера появится навигейшн бар
        let rootViewController = UINavigationController(rootViewController: loginWeatherViewController)
        //        Выбираем первый контроллер для отображения
        window?.rootViewController = rootViewController
        //        Отображаем контроллер
        window?.makeKeyAndVisible()
        //        Инициализируем Firebase при входе в приложение
        FirebaseApp.configure()
        
        return true
    }
}

