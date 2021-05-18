//
//  QuoteModel.swift
//  QuotesApp
//
//  Created by Bukhari Syed Saood on 12/22/20.
//

import UIKit

class QuoteModel {
    
    public var author: String
    public var quote: String
    public var quoteId: String
    public var picture: String
    public var time: String
    public var date: String
    public var catID: String
    public var catName: String
    public var subCatName: String
    
    init(author: String, quote: String, quoteId: String, picture: String, time: String, date: String, catID: String,catName: String,subCatName: String) {
        self.quote = quote
        self.author = author
        self.quoteId = quoteId
        self.picture = picture
        self.time = time
        self.date = date
        self.catID = catID
        self.subCatName = subCatName
        self.catName = catName
    }
}
