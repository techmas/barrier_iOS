//
//  LoginRouterVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 20.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class LoginRouterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserAPI.shared.getTokenAndPhoneNumber().token != nil {
            self.performSegue(withIdentifier: "showMainScreen", sender: self)
        } else {
            self.performSegue(withIdentifier: "showLoginScreen", sender: self)
        }
    }

}
