//
//  RoundedUIButtonWithProgress.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 01.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class RoundedUIButtonWithProgress: UIButton {
    
    var shadowAdded: Bool = true
    
    @IBInspectable var cornerRadius: CGFloat = 21 {
        didSet {
            super.layoutSubviews()
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        
        if shadowAdded { return }
        shadowAdded = true
        
        let shadowLayer = UIView(frame: self.frame)
        shadowLayer.backgroundColor = UIColor.clear
        shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        shadowLayer.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.layer.shadowOpacity = 0.5
        shadowLayer.layer.shadowRadius = 1
        shadowLayer.layer.masksToBounds = true
        shadowLayer.clipsToBounds = false
        
        self.superview?.addSubview(shadowLayer)
        self.superview?.bringSubview(toFront: self)
    }
    
}

