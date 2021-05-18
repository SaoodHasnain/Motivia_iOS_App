//
//  Category.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/03/2021.
//

import Foundation

class Category {
    private(set)  var catID:String
    public var name:String
    public var img:String
    
    init(catID:String,name:String,img:String) {
        self.catID = catID
        self.img = img
        self.name = name
    }
}
