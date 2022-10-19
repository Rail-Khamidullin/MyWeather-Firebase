//
//  Animate.swift
//  MyWeather
//
//  Created by Rail on 01.07.2022.
//

import Foundation
import  UIKit

//   Структурв с анимацией для любого объекта
struct Animator {
    
    //MARK: - Animation. Анимация для любого объекта
    
    func animateAnyObjects<T: UIView>(animateObject type: T) {
        //        Увеличиваем изображение
        let scaleGrowTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //        Уменьшаем изображение
        let scaleShrinkTransform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.autoreverse, .repeat]) {
            type.transform = scaleGrowTransform.concatenating(scaleShrinkTransform)
        }
    }
    //    Появление объекта на 4 секунды и исчезновение после
    func loseAnyObject<T: UIView>(animateObject type: T) {
        
        UIView.animate(withDuration: 4,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            //            Объект появляется на 4 секунды
            type.alpha = 1
        } completion: { (complete) in
            //            и снова исчезает
            type.alpha = 0
        }
    }
}
