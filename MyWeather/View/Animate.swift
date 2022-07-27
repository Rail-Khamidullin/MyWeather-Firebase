//
//  Animate.swift
//  MyWeather
//
//  Created by Rail on 01.07.2022.
//

import Foundation
import  UIKit


class Animate {
    
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
}
