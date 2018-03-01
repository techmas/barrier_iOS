//
//  TabBarUIButton.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 01.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable
class TabBarUIButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updatePresentation()
    }
    
    // To make title below image
    @IBInspectable var padding: CGFloat = 3 {didSet {updatePresentation()}}
    
    func updatePresentation() {
        
        self.titleLabel!.font = self.titleLabel!.font.withSize(10)
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePresentation()
    }
    
    
}
