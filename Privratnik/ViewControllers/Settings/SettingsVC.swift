//
//  SettingsVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 27.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

var isRightHandOrientation = false

class SettingsVC: UIViewController {

    @IBOutlet weak var rightHandOrientstionUISwitch: UISwitch!
    @IBAction func rightHandOrientationUISwitchChanged(_ sender: Any) {
        isRightHandOrientation = rightHandOrientstionUISwitch.isOn
    }
    
   var delegate:UserCanInitiateLogout?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rightHandOrientstionUISwitch.isOn = isRightHandOrientation
        // Do any additional setup after loading the view.
    }

    @IBAction func logOutButtonPressed(_ sender: Any) {
        // to remake
        UserAPI.shared.removeTokenAndPhoneNumber()
        
        delegate?.userInitiatedLogoutProcedure()
        
        
    }
    
    @IBAction func startDemoButtonPressed(_ sender: Any) {
        displayAlert("Раздел в разработке, попробуйте еще раз чуть позже")
    }
    
}
