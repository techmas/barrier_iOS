//
//  LoginEnterSmsCodeVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 21.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class LoginEnterSmsCodeVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var smsCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == smsCodeTextField {
            performSegue(withIdentifier: "showMainScreen", sender: self)
            
        }
    }


}
