//
//  RoundedUIView.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 26.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class RoundedUIView: UIView {
    
    @IBInspectable var masksToBounds:Bool = true {didSet{
        updatePresentation()
        }}
    
    @IBInspectable var innerShadowEnabled:Bool = false {didSet{
        updatePresentation()
        }}
    
    @IBInspectable var cornerRadius:CGFloat = 21 {didSet{
        updatePresentation()
        }}
    
    @IBInspectable var shadowRadius:CGFloat = 5{didSet{
        updatePresentation()
        }}
    
    func updatePresentation(){
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        if innerShadowEnabled {setupShadow()}
    }
    
    func setupShadow(){
        self.addShadow(to: [.top], radius: shadowRadius)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePresentation()
    }
}
