//
//  AlertHelper.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 16.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func displayAlert(_ message: String = "Не удалось выполнить операцию.") {
        let alertController = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func displayAlertWithHandler(_ message:String, handler: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
