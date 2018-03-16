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
            let barrier_id = json["barrier_id"].string,
            let phone = json["opening_number"].string
                else { return nil }
        
        self.name = name
        self.barrier_id = barrier_id
        self.phone = phone
    }
}


 class FakeModel {
    init() {}
    static let shared = FakeModel()
    var shlagbaumArray:[Shlagbaum] = [Shlagbaum(name: "Въезд домой", adress: "ул. Якиманка д.22",phone: "3232323", photo: #imageLiteral(resourceName: "plug"), photoURL: nil, needsUpdate: false), Shlagbaum(name: "Бизнес-центр Зефир", adress: "ул. Тушаковского д.1",phone: "3232311111", photo: #imageLiteral(resourceName: "plug"), photoURL: nil, needsUpdate: false), Shlagbaum(name: "Коттедж", adress: "ул. Сиреневая 24",phone: "99999", photo: #imageLiteral(resourceName: "plug"), photoURL: nil, needsUpdate: true)]
}
