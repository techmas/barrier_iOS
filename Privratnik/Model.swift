//
//  Model.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 01.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation
import UIKit


struct Shlagbaum {
    var name: String?
    var adress:String?
    var phone: String?
    var photo: UIImage?
    var photoURL: String?
    var needsUpdate:Bool?
    
    init(name:String?,adress:String?,phone: String,photo:UIImage?,photoURL:String?,needsUpdate:Bool?) {
        self.name = name
        self.adress = adress
        self.phone = phone
        self.photo = photo
        self.photoURL = photoURL
        self.needsUpdate = needsUpdate
    }
}

class FakeModel {
    init() {}
    static let shared = FakeModel()
    var shlagbaumArray:[Shlagbaum] = [Shlagbaum(name: "Въезд домой", adress: "ул. Якиманка д.22",phone: "3232323", photo: nil, photoURL: nil, needsUpdate: false), Shlagbaum(name: "Бизнес-центр Зефир", adress: "ул. Тушаковского д.1",phone: "3232311111", photo: nil, photoURL: nil, needsUpdate: false), Shlagbaum(name: "Коттедж", adress: "ул. Сиреневая 24",phone: "99999", photo: nil, photoURL: nil, needsUpdate: true)]
}
