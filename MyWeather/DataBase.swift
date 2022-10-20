//
//  DataBase.swift
//  MyWeather
//
//  Created by Rail on 19.10.2022.
//

import Foundation
import Firebase

protocol DataBaseProtocol {
    func createUser()
    func saveCity(city cityName: String?)
}

class DataBase: DataBaseProtocol {
    
    //    Создаём нового пользователя
    var users: Users!
    //    Через референс мы можем добраться до нужных нам данных (некий проводник)
    var ref: DatabaseReference!
    //    Требуется массив городов для отображения данных, у массива ставим () для обнуления задач т.к. делаем это локально
    var arrayCities = [City]()
    
    func createUser() {
        //        Создаём текущего пользователя. Необходимо сделать проверку
        guard let currentUser = Auth.auth().currentUser else { return }
        //        Передаём данные нашего зарегестрированного пользователя в нашу структуру users
        users = Users(users: currentUser )
        //        Создаём ссылку на нашего пользователя
        ref = Database.database().reference(withPath: "users").child(String(users.id)).child("cities")
    }
    //    Метод по сохранению названия городов в Firebase
    func saveCity(city cityName: String?) {
        
        guard let cityName = cityName,
              cityName != "" else { return }
        //        Создаём город
        let city = City(cityName: cityName, userID: self.users.id)
        //        Указываем расположение города на сервере, т.е. создать референс. Имя города будет использоваться в качестве папки, где будет находиться город
        let cityRef = self.ref.child(city.cityName.lowercased())
        //        По адресу референса помещаем созданный город
        cityRef.setValue(city.convertToDictionary())
    }
}
