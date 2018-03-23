//
//  Model.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 01.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


struct Shlagbaum {
    var name: String?
    var adress:String?
    var phone: String?
    var photo: UIImage?
    var photoURL: String?
    var needsUpdate:Bool?
    var barrier_id:String?
    
    init(name:String?,adress:String?,phone: String,photo:UIImage?,photoURL:String?,needsUpdate:Bool?) {
        self.name = name
        self.adress = adress
        self.phone = phone
        self.photo = photo
        self.photoURL = photoURL
        self.needsUpdate = needsUpdate
    }
    
    init?(fromJSON json: JSON) {
        guard let name = json["user_info"].string,
            let barrier_id = json["id"].string,
            let phone = json["number"].string
                else { return nil }
        let needsUpdate = json["old"].string // may be nil
        let adress = json["address"].string
        
        self.name = name
        self.barrier_id = barrier_id
        self.phone = phone
        self.adress = adress
        if needsUpdate == "1" {
            self.needsUpdate = true
        }
        
        // Photo
        self.photo = UserAPI.shared.getImageFor(barrierId: barrier_id)
        
    }
}


 class FakeModel {
    init() {}
    static let shared = FakeModel()
    var shlagbaumArray:[Shlagbaum] = []
    
}
