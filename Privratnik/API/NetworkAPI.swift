//
//  NetworkAPI.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 15.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkAPI {
    
    class func requestSMSCode(phone:String, completion: @escaping (_ success:Bool?, _ errorMessage: String?) -> Void){
        
        Alamofire.request(Router.requestSMScode(phone: phone)).validate().responseJSON { response in
            print (response)
            switch response.result {
            case .success(let responseData):
                let responseJSON = JSON(responseData)
                print (responseJSON)
                guard let status = responseJSON["state"].double else {
                    completion(false, GlobalConstants.AlertMessages.unknownReponseFromServer)
                    return
                }
                
                if status != 1 {
                    completion(false, GlobalConstants.AlertMessages.serverSideProblem)
                    return
                }
                
                completion(true, nil)
            case .failure(let error):
                print ("Alamofire request completed with \(error)")
                completion(false, error.localizedDescription)
            }
        }
    }
    
    class func submitSMSCode(phone:String, SMSCode:String, completion: @escaping (_ status:Bool?,_ token:String?, _ errorMessage: String?) -> Void){
        
        Alamofire.request(Router.submitSMScode(phone: phone, SMSCode: SMSCode)).validate().responseJSON { response in
            switch response.result {
            case .success(let responseData):
                let responseJSON = JSON(responseData)
                print (responseJSON)
                guard let token = responseJSON["key"].string else {
                    completion(false, nil, GlobalConstants.AlertMessages.probablyWrongSMScode)
                    return
                }
                
                completion(true, token, nil)
            case .failure(let error):
                print ("Alamofire request completed with \(error)")
                completion(false,nil, error.localizedDescription)
                
            }
        }
    }
    
    class func getBarriers(phone:String, token:String, completion: @escaping (_ result:Bool?,_ errorMessage: String?) -> Void) {
        Alamofire.request(Router.getBarriers(phone: phone, token: token)).validate().responseJSON { response in
            switch response.result {
            case .success(let responseData):
                let responseJSON = JSON(responseData)
                
                if let badToken = responseJSON["login"].double {
                    if badToken == 1 {
                        completion(false, GlobalConstants.AlertMessages.defaultAuthFail)
                        return
                    }
                }
                
                guard let shlagbaumArray = responseJSON.array else {
                    completion(false, GlobalConstants.AlertMessages.serverSideProblem)
                    return
                }
                
                for shlagbaumJSON in shlagbaumArray {
                    if let shlagbaum = Shlagbaum(fromJSON: shlagbaumJSON) {
                        FakeModel.shared.shlagbaumArray.append(shlagbaum)
                    }
                }
                
                completion(true, nil)
                
                
            case .failure(let error):
                print ("Alamofire request completed with \(error)")
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    class func openBarrier(phone:String, token:String, barrierId:String, completion: @escaping (_ result:Bool?,_ errorMessage: String?) -> Void) {
        
        Alamofire.request(Router.openBarrier(phone: phone, token: token, barrier_id: barrierId)).validate().responseJSON { response in
            switch response.result{
            case .success(let responseData):
                let responseJSON = JSON(responseData)
                print (responseJSON)
                guard let status = responseJSON["state"].double else {
                    completion(false, GlobalConstants.AlertMessages.unknownReponseFromServer)
                    return
                }
                
                if status != 1 {
                    completion(false, GlobalConstants.AlertMessages.serverSideProblem)
                    return
                }
                
                completion(true, nil)
            case .failure(let error):
                print ("Alamofire request completed with \(error)")
                completion(false, GlobalConstants.AlertMessages.serverSideProblem)
            }
        }
        
    }
}

