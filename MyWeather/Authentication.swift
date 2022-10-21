//
//  Authentication.swift
//  MyWeather
//
//  Created by Rail on 20.10.2022.
//

import Foundation
import Firebase

protocol AuthenticationProtocol {
    func createUser(email: String, password: String, navController: UINavigationController?, completion: @escaping (String) -> ())
}

//   Проверяем пользователя зарегестрирован он или нет
class Authentication: AuthenticationProtocol {
    
    //    Через референс мы можем добраться до нужных нам данных (некий проводник)
    var ref: DatabaseReference!
    
    //    Создаём пользователя при идентификации
    func createUser(email: String, password: String, navController: UINavigationController?, completion: @escaping (String) -> ()) {
        
        //        Создаём пользователя
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            //            Проверяем наличие записей
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                completion(error?.localizedDescription as! String)
                return
            }
            //            Создаём пользователя
            let userRef = self?.ref.child((user?.user.uid)!)
            //            Добавляем в массив значение по ключу email
            userRef?.setValue(["email": user?.user.email])
            
            //            Достаём доступ до CurrentWeatherViewController
            let currentWeatherViewController = CurrentWeatherViewController()
            //                        Совершаем переход
            navController?.pushViewController(currentWeatherViewController, animated: true)
        }
    }
}
