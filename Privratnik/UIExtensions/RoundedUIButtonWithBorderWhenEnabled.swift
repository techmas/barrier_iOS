//
//  RoundedUIButton.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 26.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class RoundedUIButtonWithBorderWhenSelected: UIButton {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 21 {
        didSet {
            super.layoutSubviews()
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override var isUserInteractionEnabled: Bool {didSet{showText()}}
    
    private func showText(){
        
        if isUserInteractionEnabled {
            
        } else {
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView?.contentMode = .scaleAspectFit
        
    }
    
}

