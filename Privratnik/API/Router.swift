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
