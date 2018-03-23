//
//  ShlagbaumTableViewCell.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 27.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

protocol CellButtonsDelegate {
    func didPressButtonWith(buttonName:String?, indexPath:IndexPath!)
}

class ShlagbaumTableViewCell: UITableViewCell {
    
    var delegate:CellButtonsDelegate?
    var shlagbaumNeedsUpdate:Bool?
    var currentIndexPath:IndexPath!
    
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
        delegate?.didPressButtonWith(buttonName: "open", indexPath: currentIndexPath)
    }
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBAction func settingsButtonPressed(_ sender: Any) {
        delegate?.didPressButtonWith(buttonName: "settings", indexPath: currentIndexPath)
    }
    
    @IBOutlet weak var cameraButton: RoundedUIButton!
    @IBAction func cameraButtonPressed(_ sender: Any) {
        delegate?.didPressButtonWith(buttonName: "camera", indexPath: currentIndexPath)
    }
    
    @IBOutlet weak var shlagbaumName: UILabel!
    @IBOutlet weak var shlagbaumAdressUILabel: UILabel!
    @IBOutlet weak var shlagbaumImageUIImage: UIImageView!
    
    
    @IBOutlet weak var cellRoundedUIView: RoundedUIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setShlagbaumPresentation()

    }
    
    func setShlagbaumPresentation(){
        if shlagbaumNeedsUpdate == nil {
            self.cellRoundedUIView.backgroundColor = UIColor.duskBlue
            self.settingsButton.setImage(#imageLiteral(resourceName: "setting1"), for: .normal)
            return
        }
        
        if shlagbaumNeedsUpdate! {
            self.cellRoundedUIView.backgroundColor = UIColor.greyishBrown
            self.settingsButton.setImage(#imageLiteral(resourceName: "setting2"), for: .normal)
        } else {
            self.cellRoundedUIView.backgroundColor = UIColor.duskBlue
            self.settingsButton.setImage(#imageLiteral(resourceName: "setting1"), for: .normal)
        }
        
    }
    
    func updateLeftRightConstraint(){
        openButtonLeftHandConstraint.isActive = UserAPI.shared.isLeftHanded()
        openButtonRightHandConstraint.isActive = !UserAPI.shared.isLeftHanded()
        settingsButtonLeftHandConstraint.isActive = UserAPI.shared.isLeftHanded()
        settingsButtonRightHandConstraint.isActive = !UserAPI.shared.isLeftHanded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
