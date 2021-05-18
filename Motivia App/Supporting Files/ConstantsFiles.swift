//
//  ConstantsFiles.swift
//  Real Estate Photo
//
//  Created by Hamza Shahbaz on 22/07/2019.
//  Copyright © 2019 Hamza Shahbaz. All rights reserved.
//

import Foundation
import Firebase



typealias CompletionHandler = (_ Success: Bool) -> ()
typealias CompletionHandlerWithError = (_ Success: Bool,_ Error:Error?) -> ()

let TO_NOTIF_USER_DATA_DID_CHANGE = Notification.Name("utifUserDataChanged")
let TO_NOTIF_FILTER_DATA_DID_CHANGE = Notification.Name("utifFilterDataChanged")

func getUniqueId()->String{
    let uid = UUID().uuidString.lowercased()
    return uid
}

func getCurrentDate() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return (formatter.string(from: Date()))
}

func getCurrentDateWithTime() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "2016-08-26T12:39:00Z"
    return (formatter.string(from: Date()))
}

func getISODate() -> String{
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    print("ISO8601 string: \(isoDateFormatter.string(from: Date()))")
    return (isoDateFormatter.string(from: Date()))
    // dateTo: 2016-12-31 23:59:59 +0000
}

func addDaysToDate(sentDate:String,days:Int) -> String{
    let isoDate = sentDate

    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    let today = dateFormatter.date(from:isoDate)!
    print("Today is :\(today)")
    print("------------")
    print("------------")
    let modifiedDate = Calendar.current.date(byAdding: .day, value: days, to: today)!
    
    print("Modified date: \(modifiedDate)")
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    print(isoDateFormatter.string(from: modifiedDate))
    return (isoDateFormatter.string(from: modifiedDate))
}

func getCurrentTime() -> Int{
    let time = Date().timeIntervalSince1970
    print(Int(time))
    return Int(time)
}

func returnDistanceTime(distanceTime: TimeInterval) -> String{

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: NSDate() as Date)
}


enum IAPProduct: String {
    case autoRenowing = "OneMonthAutoRenowing"
}

func timeIncreaseAndDecrease(time: String, addedTime: Int) -> String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let date = formatter.date(from: time)
    let thirtyMinutesLater = Calendar.current.date(byAdding: .minute, value: addedTime, to: date!)!
    return formatter.string(from: thirtyMinutesLater)
}

