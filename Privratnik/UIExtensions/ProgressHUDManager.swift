//
//  ProgressHUDManager.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 16.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressHUDManager {
    
    static let shared = ProgressHUDManager()
    fileprivate var hud: MBProgressHUD?
    
    func showHUD() {
        if let applicationView = UIApplication.shared.delegate?.window??.rootViewController?.view {
            hud = MBProgressHUD.showAdded(to: applicationView, animated: true)
        }
    }
    
    func hideHUD() {
        if let hud = hud {
            hud.hide(animated: true)
            self.hud = nil
        }
    }
}

