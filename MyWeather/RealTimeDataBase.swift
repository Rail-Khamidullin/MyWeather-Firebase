//
//  DataBase.swift
//  MyWeather
//
//  Created by Rail on 19.10.2022.
//

import Foundation
import Firebase


//   Создаём сущность от которой будет зависеть класс DataBase
protocol DataBaseProtocol {
    func createUser()
    func saveCity(city cityName: String?)
    func observeCity(cityArray: @escaping ([City]) -> ())
}

//   Класс будет создавать пользователя, хранить данные и передавать их
final class RealTimeDataBase: DataBaseProtocol {
    
    //    Создаём нового пользователя
    var users: Users!
    //    Через референс мы можем добраться до нужных нам данных (некий проводник)
    var ref: DatabaseReference!
    //    Требуется массив городов для отображения данных, у массива ставим () для обнуления задач т.к. делаем это локально
    var arrayCities = [City]()
    
    //    Создаём пользователя и ссылку на него
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
    
    //    Для получения данных необходимо поставить наблюдателя в методе, так прописано в Firebase. А уже далее передадим наш массив с городами
    func observeCity(cityArray: @escaping ([City]) -> ()) {
        //        Делаем срез данных (snapshot)
        ref.observe(.value) { (snapshot) in
            //             Создаём массив для того, чтобы не дублировать информацию в уже имеющемся массиве cities, потому что каждый раз, когда мы будем добавлять город он будет дублировать все ранее запрошенные города в массив
            var citiesArray = [City]()
            //            Пройдём по всем имеющимся значениям в database
            for item in snapshot.children {
                //                Делаем срез (фото) наших данных
                let city = City(snapshot: item as! DataSnapshot)
                //                Добавляем данные в выше созданный массив
                citiesArray.append(city)
                cityArray(citiesArray)
            }
        }
    }
}
