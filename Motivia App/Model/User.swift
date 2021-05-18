//
//  User.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/03/2021.
//

import Foundation


class UserModel {
    var userId: String
    var startTime: String
    var endTime : String
    var quantity: String
    var deviceId: String
    var target: [String]
    var themeId: String
    var deviceTpe: String
    var likes : [String]
    
    init(userId: String, startTime: String, endTime: String, quantity: String, deviceId: String, target: [String], themeid: String, deviceTpe: String, likes:[String] ) {
        self.userId = userId
        self.startTime = startTime
        self.endTime = endTime
        self.quantity = quantity
        self.deviceId = deviceId
        self.target = target
        self.themeId = themeid
        self.deviceTpe = deviceTpe
        self.likes = likes
    }
}
