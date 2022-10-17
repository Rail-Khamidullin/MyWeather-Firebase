//
//  User.swift
//  MyWeather
//
//  Created by Rail on 17.10.2022.
//

import Foundation
import Firebase


//   Каждый зарегестрированный пользователь будет иметь ID и почту
struct Users {
     
    let id: String
    let email: String
    
//    После регистрации пользователя мы получаем абстактного готового пользователя и присваиваем значения для работы с данными уже локально
    init(users: User) {
        self.id = users.uid
        self.email = users.email!
    }
}
