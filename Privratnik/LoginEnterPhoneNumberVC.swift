//
//  LoginEnterPhoneNumberVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 21.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit
import AudioToolbox

class LoginEnterPhoneNumberVC: UIViewController {

    var screenState:LoginScreenStates = .enteringPhoneNumber {didSet{setScreenState()}}
    var timer:Timer?
    var seconds = 30
    
    @IBOutlet weak var phoneNumberTextField: RoundedUITextFieldMasked!
    @IBOutlet weak var smsCodeTextField: RoundedUITextFieldMasked!
    @IBOutlet weak var getSmsButton: RoundedUIButton!
    @IBAction func getSmsButtonPressed(_ sender: Any) {
        screenState = .enteringSmsCode
        smsCodeButtonVisibilityTimerActivate()
        getSmsButton.isHidden = true
        phoneNumberTextField.endEditing(true)
    }
    
    @IBOutlet weak var enterSmsCodeLabel: UILabel!
    @IBOutlet weak var sendSmsCodeOnceAgainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenState = .enteringPhoneNumber
    }
   
    // Timer
    
    private func smsCodeButtonVisibilityTimerActivate(){
        // Логика повторной отправки смс-кода только через 30 секунд
        seconds = 30
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        sendSmsCodeOnceAgainLabel.text = "Повторить отправку можно будет через \(seconds) с"
        if seconds == 0 {
            timer?.invalidate()
            getSmsButton.isHidden = false
            sendSmsCodeOnceAgainLabel.isHidden = true
            sendSmsCodeOnceAgainLabel.text = "Повторить отправку можно будет через 30 с"
        }
        
    }

    
    // Timer
    
    private func setScreenState(){
        switch screenState {
        case .enteringPhoneNumber:
            smsCodeTextField.isHidden = true
            enterSmsCodeLabel.isHidden = true
            sendSmsCodeOnceAgainLabel.isHidden = true
            getSmsButton.setTitle(LoginScreenLocalizedStrings.ButtonTitles.getSmsCode, for: .normal)
        case .enteringSmsCode:
            smsCodeTextField.isHidden = false
            enterSmsCodeLabel.isHidden = false
            sendSmsCodeOnceAgainLabel.isHidden = false
        getSmsButton.setTitle(LoginScreenLocalizedStrings.ButtonTitles.getAnotherSmsCode, for: .normal)
            
        }
    }
    
    private func smsCodeEntered(){
        
        let wrongCodeAlert = UIAlertController(title: "Ошибка", message: "Введенный код неверен. Попробуем еще раз?", preferredStyle: UIAlertControllerStyle.alert)
        wrongCodeAlert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default,
                                               handler: {action in self.smsCodeTextField.text = ""}))
        
        // To Be removed
        let alert = UIAlertController(title: "//Отладка", message: "Притворимся, что код верный?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Да", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "showMainScreen", sender: self)}))
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel, handler: {action in
            AudioServicesPlaySystemSound(1519) // Vibrate!
            self.present(wrongCodeAlert, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}

extension LoginEnterPhoneNumberVC: UITextFieldDelegate {
    
    
    // Values observer
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textFieldToChange {
        case smsCodeTextField:
            // limit to 4 characters
            let characterCountLimit = 4
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            if newLength == characterCountLimit {smsCodeEntered()}
            
        case phoneNumberTextField:
            let characterCountLimit = 17
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            getSmsButton.isHidden = !(newLength >= characterCountLimit)
            
            if newLength < startingLength {
                screenState = .enteringPhoneNumber
                timer?.invalidate()
                sendSmsCodeOnceAgainLabel.text = "Повторить отправку можно будет через 30 с"
            }
            
        default:
            // do nothing
            print ("some unknown textField entered")
        }
        
        return true
    }
    
}




enum LoginScreenStates {
    case enteringPhoneNumber
    case enteringSmsCode
}

enum LoginScreenLocalizedStrings{
    enum ButtonTitles {
        static let getSmsCode = "Получить SMS-код"
        static let getAnotherSmsCode = "Отправить код повторно"
    }
}
