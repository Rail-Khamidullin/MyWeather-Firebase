//
//  ExtensionNavigationController.swift
//  MyWeather
//
//  Created by Rail on 14.10.2022.
//

import UIKit

extension UINavigationController {
    
    func setBackButton(with title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        viewControllers.last?.navigationItem.backBarButtonItem = backButton
    }
}
