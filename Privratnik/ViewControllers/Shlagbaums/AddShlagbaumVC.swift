//
//  AddShlagbaumVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 27.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class AddShlagbaumVC: UIViewController {
    @IBAction func backButtonPressed(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var shlagbaumNameTextField: RoundedUITextField!
    
    @IBOutlet weak var shlagbaumNumberTextField: RoundedUITextFieldMasked!
    
    @IBOutlet weak var shlagbaumAdressTextField: RoundedUITextField!
    
    @IBOutlet weak var addButton: RoundedUIButton!
    @IBAction func addButtonPressed(_ sender: Any) {
        FakeModel.shared.shlagbaumArray.append(Shlagbaum(name:shlagbaumNameTextField.text,
                                                         adress: shlagbaumAdressTextField.text,
                                                         phone: shlagbaumNumberTextField.text!,
                                                         photo: nil,
                                                         photoURL: nil,
                                                         needsUpdate: nil))
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
}

extension AddShlagbaumVC:UITextFieldDelegate{
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textFieldToChange {
            
        case shlagbaumNumberTextField:
            let characterCountLimit = 17
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            if (newLength >= characterCountLimit) {
                addButton.isEnabled = true
                shlagbaumNumberTextField.layer.backgroundColor = UIColor.white.cgColor
                shlagbaumNumberTextField.borderEnabled = false
                
            } else {
                addButton.isEnabled = false
                shlagbaumNumberTextField.layer.backgroundColor = UIColor.brick.cgColor
                shlagbaumNumberTextField.borderEnabled = true
            }

        default:
            // do nothing
            print ("some unknown textField entered")
        }
        
        return true
    }
}
