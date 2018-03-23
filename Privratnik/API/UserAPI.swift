//
//  UserAPI.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 15.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.

import Foundation
import KeychainSwift

class UserAPI {
    
    static let shared = UserAPI()
    private init() {
       initUserDefaults()
    }
    
    // MARK: Token & Keychain
    
    private let keychain = KeychainSwift()
    private let tokenKey = "ru.techmas.privratnik.token"
    private let phoneKey = "ru.techmas.privratnik.phoneNumber"
    
    func setTokenAndPhoneNumber(token:String, phone:String) -> Bool {
        return keychain.set(token, forKey: tokenKey) && keychain.set(phone, forKey: phoneKey)
    }
    
    func getTokenAndPhoneNumber() -> (token:String?, phone:String?) {
        let token = keychain.get(tokenKey)
        let phone = keychain.get(phoneKey)
        
        return (token,phone)
    }
    
    func removeTokenAndPhoneNumber() -> Bool {
        return keychain.delete(tokenKey) && keychain.delete(phoneKey)
    }
    
    // MARK: UserDefaults
    
    private let userDefaults = UserDefaults.standard
    
    private func initUserDefaults(){
        
        print (userDefaults.bool(forKey: "isLeftHanded"))
        
    }
    
    func isLeftHanded() -> Bool {
        return userDefaults.bool(forKey: "isLeftHanded")
    }
    
    func isLeftHanded(_ value: Bool) {
        userDefaults.set(value, forKey: "isLeftHanded")
    }
    
    
    // MARK: Saving user's barrier image
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImage(image: UIImage, for barrierId: String){
            if let data = UIImagePNGRepresentation(image) {
                let filename = getDocumentsDirectory().appendingPathComponent("\(barrierId).png")
                try? data.write(to: filename)
            }
    }
    
    func getImageFor(barrierId: String) -> UIImage? {
        
        let imageURL = getDocumentsDirectory().appendingPathComponent("\(barrierId).png")
        guard let image = UIImage(contentsOfFile: imageURL.path) else {return nil}
        
        return image
    }

}

