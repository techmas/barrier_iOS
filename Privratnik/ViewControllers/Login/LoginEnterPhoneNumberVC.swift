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
    var seconds = 60
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneNumberTextField: RoundedUITextFieldMasked!
    @IBOutlet weak var smsCodeTextField: RoundedUITextFieldMasked!
    @IBOutlet weak var getSmsButton: RoundedUIButton!
    @IBAction func getSmsButtonPressed(_ sender: Any) {
        getSMSCodeButtonPressed()
    }
    
    @IBOutlet weak var enterSmsCodeLabel: UILabel!
    @IBOutlet weak var sendSmsCodeOnceAgainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        screenState = .enteringPhoneNumber
        //addObserversForKeyboardAppearanceToMoveScrollView (vc: self, scrollView: scrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserAPI.shared.getTokenAndPhoneNumber().token != nil {
            self.performSegue(withIdentifier: "showMainScreen", sender: self)
        }
    }
   
    // Timer
    
    private func smsCodeButtonVisibilityTimerActivate(){
        // Логика повторной отправки смс-кода только через 30 секунд
        seconds = 60
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
        
        guard var phoneNumber = phoneNumberTextField.unmaskedText else {return}
        guard let smsCode = smsCodeTextField.text else {return}
        
        //print (smsCode)
        
        
        ProgressHUDManager.shared.showHUD()
        NetworkAPI.submitSMSCode(phone: phoneNumber, SMSCode: smsCode) {
            [weak self] (success, token, errorMessage) in
            ProgressHUDManager.shared.hideHUD()
            self?.handleServerResponseWithToken(success,token,errorMessage)
        }
    }
    
    private func handleServerResponseWithToken(_ success:Bool?,_ token: String?,_ errorMessage:String?){
        
        if errorMessage != nil {
            displayAlert(errorMessage!)
            return
        }
        
        if success == nil {
            displayAlert(GlobalConstants.AlertMessages.serverSideProblem)
            return
        }
        
        if !success! {
            displayAlert(GlobalConstants.AlertMessages.serverSideProblem)
            return
        }
        
        guard let token = token else {
            wrongCodeAlert("Введенный код неверен. Попробуем еще раз?")
            return
        }
        
        guard let phone = phoneNumberTextField.unmaskedText else {
             displayAlert("Неверный номер телефона")
            return
        }
        
        if UserAPI.shared.setTokenAndPhoneNumber(token: token,phone: phone) {
            self.performSegue(withIdentifier: "showMainScreen", sender: self)
        } else {
            displayAlert(GlobalConstants.AlertMessages.unknownError)
        }
        
    }
    
    private func wrongCodeAlert(_ message:String){
        AudioServicesPlaySystemSound(1519) // Vibrate!
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        displayAlert(message)
    }
    
    private func getSMSCodeButtonPressed(){
        
        guard let phoneNumber = phoneNumberTextField.unmaskedText else {return}
        
        ProgressHUDManager.shared.showHUD()
        NetworkAPI.requestSMSCode(phone: phoneNumber) {
            [weak self] (success, errorMessage) in
            ProgressHUDManager.shared.hideHUD()
            self?.handleSmsCodeRequestResponse(success,errorMessage)
        }
       
       
    }
    
    private func handleSmsCodeRequestResponse(_ success:Bool?,_ errorMessage:String?){
        if errorMessage != nil {
            displayAlert(errorMessage!)
            return
        }
        if success == nil {
            displayAlert(GlobalConstants.AlertMessages.serverSideProblem)
            return
        }
        screenState = .enteringSmsCode
        smsCodeButtonVisibilityTimerActivate()
        getSmsButton.isHidden = true
        phoneNumberTextField.endEditing(true)
        
    }
    
}

extension LoginEnterPhoneNumberVC: UITextFieldDelegate {
    
    
    // Values observer
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textFieldToChange {
        case smsCodeTextField:
            // limit to 5 characters
            let characterCountLimit = 5
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            print("длина строки \(newLength)")
            if newLength == characterCountLimit {
                DispatchQueue.main.async {
                    self.smsCodeEntered()
                }
                
            }
            
        case phoneNumberTextField:
            let characterCountLimit = 17
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            // avoid 1st entered number 7 and 8
            
            /*
            if startingLength == 0 {
                print (string)
                if string == "7" {
                    return false
                }
                
                if string == "8"{
                    return false
                }
            }
             */
            
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == smsCodeTextField {
           scrollView.setContentOffset(CGPoint(x:0, y:80), animated: true)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == smsCodeTextField {
           scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
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
