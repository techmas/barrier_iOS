//
//  TabBarUIView.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 28.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit

class TabBarUIView: UIView {
    
    @IBInspectable var uplined: Bool = true {didSet {updateBorder()}}
    @IBInspectable var borderWith: CGFloat = 1 {didSet {updateBorder()}}
    @IBInspectable var borderColor: UIColor = .lightGray {didSet {updateBorder()}}
    
    
    private func updateBorder() {
        if uplined {
            let border = CALayer()
            let width = borderWith
            border.borderColor = borderColor.cgColor
            border.frame = CGRect(x: 45 , y: 0,   width:  self.frame.size.width - 45 - 45, height: borderWith)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
}
