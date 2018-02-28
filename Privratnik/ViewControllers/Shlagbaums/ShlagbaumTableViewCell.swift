//
//  ShlagbaumTableViewCell.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 27.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class ShlagbaumTableViewCell: UITableViewCell {
    
    // Constraints for left-rught ganded operation
    @IBOutlet weak var openButtonLeftHandConstraint: NSLayoutConstraint!
    @IBOutlet weak var openButtonRightHandConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsButtonRightHandConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingsButtonLeftHandConstraint: NSLayoutConstraint!
    // buttons
    @IBOutlet weak var openButton: RoundedUIButton!
    @IBAction func openButtonPressed(_ sender: Any) {
        openButton.backgroundColor = UIColor.green
        openButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.openButton.backgroundColor = UIColor.white
            self.openButton.isEnabled = true
        })
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    func updateLeftRightConstraint(){
        openButtonLeftHandConstraint.isActive = !isRightHandOrientation
        openButtonRightHandConstraint.isActive = isRightHandOrientation
        settingsButtonLeftHandConstraint.isActive = !isRightHandOrientation
        settingsButtonRightHandConstraint.isActive = isRightHandOrientation
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
