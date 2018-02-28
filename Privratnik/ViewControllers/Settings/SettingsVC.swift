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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rightHandOrientstionUISwitch.isOn = isRightHandOrientation
        // Do any additional setup after loading the view.
    }



}
