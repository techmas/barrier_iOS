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
    private init() {}
    
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
    
    /*
    private func setToken(_ token: String) -> Bool {
        return keychain.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return keychain.get(tokenKey)
    }
    
    func removeToken() -> Bool {
        return keychain.delete(tokenKey)
    }
    */
    
    // MARK: Something else
    
    
}

