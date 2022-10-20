//
//  City.swift
//  MyWeather
//
//  Created by Rail on 19.10.2022.
//

import Foundation
import Firebase

//   Создаём город
struct City {
//      Название города
    let cityName: String
//    Обезательно присваивается каждому пользователю
    let userID: String
    //    Все объекты имеют точное расположение и чтобы добраться необходим Reference. Из-за того что мы создаём его локально, он будет опциональным
    let ref: DatabaseReference?
    var completed: Bool = false
//    Инициализато нужен, чтобы создать пользователя локально
    init(cityName: String, userID: String) {
        self.cityName = cityName
        self.userID = userID
        self.ref = nil
    }
    
    ///   Инициализатор для извлечения данных
    /// - Parameter snapshot: Когда хранятся данные в базе данных и требуется текущая информация, то мы обращаемся к DataSnapshot (некий снимок, срез данных, как-будто фотография данных). Этот Snapshot и есть JSON
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String : AnyObject]
        cityName = snapshotValue["title"] as! String
        userID = snapshotValue["userID"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["cityName": cityName, "userID" : userID, "completed" : completed]
    }
}
