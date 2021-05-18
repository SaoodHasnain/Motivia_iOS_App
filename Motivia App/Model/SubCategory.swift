//
//  SubCategory.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/03/2021.
//

import Foundation
class SubCategory {
    private(set)  var subCatID:String
    public var name:String
    public var img:String
    public var catName:String
    public var catID:String
    
    init(subCatID:String,name:String,img:String,catName:String,catID:String) {
        self.subCatID = catID
        self.img = img
        self.catName = catName
        self.name = name
        self.catID = catID
    }
}
