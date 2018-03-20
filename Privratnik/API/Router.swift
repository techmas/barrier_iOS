//
//  Router.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 15.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

    case requestSMScode(phone:String)
    case submitSMScode(phone:String, SMSCode:String)
    case getBarriers(phone:String, token:String)
    case openBarrier(phone:String, token:String, barrier_id:String)
    case openBarrierViaGSM(phone:String, token:String, barrierPhoneNumber:String)
    case addBarrier(phone:String, token:String, barrierPhoneNumber:String, barrierName:String, barrierAdress:String)
    case removeBarrier(phone:String, token:String, barrier_id:String)
    case updateBarrier(phone:String, token:String, barrier_id:String, barrierName:String?, address:String?, pointX:String?, pointY:String? )
    
    static let baseURLString = "https://api.privratnik.net:44590/app/api.php"
    
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var parameters: ([String: Any]?) = nil
        switch self {
        case .requestSMScode(let phone):
            parameters = [
                "number": phone
            ]
            
        case .submitSMScode(let phone, let SMSCode):
            parameters = [
                "number":phone,
                "smsCode":SMSCode
            ]
            
        case .getBarriers(let phone, let token):
            parameters = [
                "login":phone,
                "key":token,
                "barrier":""
            ]
            
        case .openBarrier(let phone, let token, let barrier_id):
            parameters = [
                "login":phone,
                "key":token,
                "command":"open",
                "barrier_id":barrier_id
            ]
        
        case .openBarrierViaGSM(let phone, let token, let barrierPhoneNumber):
            parameters = [
                "login":phone,
                "key":token,
                "from":phone,
                "to":barrierPhoneNumber
            ]
           
        case .addBarrier(let phone, let token, let barrierPhoneNumber, let barrierName, let barrierAdress):
            parameters = [
                "login":phone,
                "key":token,
                "addBarrier":"",
                "tel_gsm":barrierPhoneNumber,
                "user_info":barrierName,
                "address":barrierAdress
            ]
            
        case .removeBarrier(let phone, let token, let barrier_id):
            parameters = [
                "login":phone,
                "key":token,
                "rmBarrier":barrier_id
            ]
            
        case .updateBarrier(let phone, let token, let barrier_id, let barrierName, let address, let pointX, let pointY):
            parameters = [
                "login":phone,
                "key":token,
                "UpBarrier":"",
                "barrier_id":barrier_id
            ]
            
            if barrierName != nil {
                parameters!.updateValue(barrierName!, forKey: "user_info")
            }
            
            if address != nil {
                parameters!.updateValue(address!, forKey: "address")
            }
            
            if pointX != nil {
                parameters!.updateValue(pointX!, forKey: "pointX")
            }
            
            if pointY != nil {
                parameters!.updateValue(pointY!, forKey: "pointY")
            }
            
            
            
        default:
            break
        }
        

        
        switch method {
        case .get:
            return try URLEncoding.default.encode(request, with: parameters)
        default:
            print (parameters)
            return try URLEncoding.httpBody.encode(request, with: parameters)
        }
    }
}
