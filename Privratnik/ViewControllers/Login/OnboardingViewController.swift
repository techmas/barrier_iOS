//
//  OnboardingViewController.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 06.04.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To be removed:
        
        performSegue(withIdentifier: "passOnboarding", sender: self)
        
        // #WARNING non-executable until line above not removed
        
        if UserAPI.shared.hasSeenOnboarding() {
           leaveOnboardingScreen()
        }
        
        // show Onboarding
        
        // done showing onboarding
        UserAPI.shared.hasSeenOnboarding(true)
        leaveOnboardingScreen()
        

        // Do any additional setup after loading the view.
    }
    
    private func leaveOnboardingScreen(){
        performSegue(withIdentifier: "passOnboarding", sender: self)
    }

}
