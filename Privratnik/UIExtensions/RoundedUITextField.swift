//
//  RoundedUITextView.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 26.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedUITextField: UITextField {
    
    @IBInspectable var masksToBounds:Bool = true {didSet{
        updatePresentation()
        }}
    
    @IBInspectable var innerShadowEnabled:Bool = false {didSet{
        updatePresentation()
        }}
    
    @IBInspectable var cornerRadius:CGFloat = 21{didSet{
        updatePresentation()
        }}
    
    @IBInspectable var shadowRadius:CGFloat = 1{didSet{
        updatePresentation()
        }}
    
    @IBInspectable var borderWidth:CGFloat = 0{didSet{
        updatePresentation()
        }}
    
    func updatePresentation(){
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        if innerShadowEnabled {setupShadow()}
        self.borderStyle = .none
        self.backgroundColor = UIColor.white
    }
    
    func setupShadow(){
        //self.addShadow(to: [.top], radius: shadowRadius)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePresentation()
    }
    
}

