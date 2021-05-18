//
//  DataService.swift
//  BlindPlate
//
//  Created by Hamza Shahbaz on 12/11/2020.
//  Copyright © 2020 Hamza Shahbaz. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import MapKit

class DataService{
    static let instance = DataService()

    let userReference = Firestore.firestore().collection("users")
    let quotesReference = Firestore.firestore().collection("quotes")
    let categoriesReference = Firestore.firestore().collection("categories")
    let subCategoriesReference = Firestore.firestore().collection("subCategories")

    var currentUser : UserModel!

    func setCurrentUser(user:UserModel){
        self.currentUser = user
    }
    
    func emptyCurrentUser(){
        currentUser = nil
    }
    
    func updateUser(user:UserModel){
        userReference.document(user.userId).setData([
            "userId":user.userId,
            "startTime":user.startTime,
            "endTime":user.endTime,
            "quantity":user.quantity,
            "deviceId":user.deviceId,
            "target":user.target,
            "themeId":user.themeId,
            "deviceType": user.deviceTpe,
            "createdAt": "\(FieldValue.serverTimestamp())",
            "likes":user.likes,

        ], merge: true) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
            }
        }
    }


    
    func updateQuote(quotes:QuoteModel){
        quotesReference.document(quotes.quoteId).setData([
            "author":quotes.author,
            "catID":quotes.catID,
            "catName":quotes.catName,
            "date":quotes.date,
            "picture":quotes.picture,
            "quote":quotes.quote,
            "quoteId":quotes.quoteId,
            "time":quotes.time,
            "subCatName":quotes.subCatName
        ], merge: true) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
            }
        }
    }
    func updateUserField(withUid: String, andField: String, toNewValue: [String]) {
        userReference.document(withUid).setData( [andField: toNewValue], merge: true)
    }
    
    
//    func getUserOfID(userID:String,handler: @escaping(_ success:Bool,_ user:UserModel?)->()){
//        let userRef = userReference.document(UserDefaults.standard.string(forKey: "userId") ?? "")
//
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()!
//                let userId = data["userId"] as? String ?? "Not Found"
//                let startTime = data["startTime"] as? String ?? ""
//                let endTime = data["endTime"] as? String ?? "Not Found"
//                let quantity = data["quantity"] as? String ?? "Not Found"
//                let deviceId = data["deviceId"] as? String ?? "Not Found"
//                let target = data["target"] as? [String] ?? [String]()
//                let themeid = data["themeid"] as? String ?? "Not Found"
//                let deviceTpe = data["deviceTpe"] as? String ?? "Not Found"
//                let likes = data["likes"] as? [String] ?? [String]()
//
//                let user = UserModel(userId: userId, startTime: startTime, endTime: endTime, quantity: quantity, deviceId: deviceId, target: target, themeid: themeid, deviceTpe: deviceTpe, likes: likes)
//                handler(true,user)
//
//            } else {
//                handler(false,nil)
//                print("Document does not exist")
//            }
//        }
//    }
    
    func getQuoteOfID(restaurant:String,handler: @escaping(_ success:Bool,_ quote:QuoteModel?)->()){
        let restaurantRef = categoriesReference.document(restaurant)
        
        restaurantRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()!
                let author = data["author"] as? String ?? "Not Found"
                let quote = data["quote"] as? String ?? "Not Found"
                let quoteId = data["quoteId"] as? String ?? "Not Found"
                let picture = data["picture"] as? String ?? ""
                let time = data["time"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let catID = data["catID"] as? String ?? ""
                let catName = data["catName"] as? String ?? ""
                let subCatName = data["subCatName"] as? String ?? ""
                
                let restaurant = QuoteModel(author: author, quote: quote, quoteId: quoteId, picture: picture, time: time, date: date, catID: catID, catName: catName, subCatName: subCatName)
                handler(true,restaurant)
                
            } else {
                handler(false,nil)
                print("Document does not exist")
            }
        }
    }
    
    func getAllQuotes(handler:@escaping(_ quotes:[QuoteModel])->()){
        var quotesArray = [QuoteModel]()
        quotesReference.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(quotesArray)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let author = data["quoteAuthor"] as? String ?? "Not Found"
                    let quote = data["quoteText"] as? String ?? "Not Found"
                    let quoteId = data["quoteId"] as? String ?? "Not Found"
                    let picture = data["picture"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let date = data["date"] as? String ?? ""
                    let catID = data["catID"] as? String ?? ""
                    let catName = data["catName"] as? String ?? ""
                    let subCatName = data["subCatName"] as? String ?? ""
                    
                    let q = QuoteModel(author: author, quote: quote, quoteId: quoteId, picture: picture, time: time, date: date, catID: catID, catName: catName, subCatName: subCatName)
                    quotesArray.append(q)
                }
                handler(quotesArray)
            }
        }
    }
    
    
    func getAllCategories(handler:@escaping(_ success:Bool,_ category:[Category])->()){
        var categoryArray = [Category]()
        categoriesReference.order(by: "messageDate", descending: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(true,categoryArray)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let img = data["img"] as? String ?? "Not Found"
                    let name = data["name"] as? String ?? "Not Found"
                    let catID = data["catID"] as? String ?? "Not Found"
                    
                    let cateogroy = Category(catID: catID, name: name, img: img)
                    categoryArray.append(cateogroy)
                    
                }
                handler(true,categoryArray)
            }
        }
    }
    
    func getAllSubCategoriesOfCategory(categoryId:String,handler:@escaping(_ success:Bool,_ category:[SubCategory])->()){
        var subCategory = [SubCategory]()
        subCategoriesReference.whereField("catID", isEqualTo: categoryId).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                handler(true,subCategory)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let img = data["img"] as? String ?? "Not Found"
                    let name = data["name"] as? String ?? "Not Found"
                    let catID = data["catID"] as? String ?? "Not Found"
                    let catName = data["catName"] as? String ?? "Not Found"
                    let subCatID = data["subCatID"] as? String ?? "Not Found"
                    
                    let cateogroy = SubCategory(subCatID: subCatID, name: name, img: img, catName: catName, catID: catID)
                    subCategory.append(cateogroy)
                    
                }
                handler(true,subCategory)
            }
        }
    }
    
    
    func uploadProfilePicture(imageName:String,image:UIImage,folderName:String, handler :@escaping(_ success:Bool,_ picUrl:String)->()){
        var downloadLink = ""
        let imageData = image.jpegData(compressionQuality: 0.8)
        let storageRef = Storage.storage().reference().child(folderName).child(("\(imageName).jpg"))
        let uploadTask = storageRef.putData(imageData!, metadata: nil) { (metaData, error) in
            print("upload task finished")
            storageRef.downloadURL(completion: { (url, error) in
                if error != nil
                {
                    print(error!)
                    handler(false, "")
                }
                else
                {
                    downloadLink = (url?.absoluteString)!
                    
                    
                    handler(true,downloadLink)
                }
            })
        }
    }
    
  
}
