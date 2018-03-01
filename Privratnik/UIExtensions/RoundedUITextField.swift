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
    
    @IBInspectable var borderEnabled:Bool = false {didSet{updatePresentation()}}
    
    
    @IBInspectable var masksToBounds:Bool = true {didSet{
        updatePresentation()
        }}
    /*
    @IBInspectable var innerShadowEnabled:Bool = false {didSet{
        updatePresentation()
        }}
    */
    @IBInspectable var cornerRadius:CGFloat = 21{didSet{
        updatePresentation()
        }}
    
    @IBInspectable var newBackgroundColor:UIColor = UIColor.white{didSet{
        updatePresentation()
        }}
    
    @IBInspectable var borderColor:UIColor = UIColor.darkGray{didSet{
        updatePresentation()
        }}
    /*
    @IBInspectable var shadowRadius:CGFloat = 1{didSet{
        updatePresentation()
        }}
    */
    @IBInspectable var borderWidth:CGFloat = 1{didSet{
        updatePresentation()
        }}
    func updatePresentation(){
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        //if innerShadowEnabled {setupShadow()}
        self.borderStyle = .none
        self.backgroundColor = newBackgroundColor
        
        if borderEnabled {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
            
        } else {
            self.layer.borderWidth = 0
        }
        
    }
    
    
    
    
    func setupShadow(){
        //self.addShadow(to: [.top], radius: shadowRadius)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePresentation()
    }
    
}

