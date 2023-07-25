//
//  MealArray + Extension.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 23.07.2023.
//

import Foundation

extension Array where Element == Meal {
    
    var representation: [Int: Meal] {
        var dict = [Int: Meal]()
        for i in 0..<self.count {
            dict[i] = self[i]
        }
        return dict
    }
    
    var rep: [String: String] {
        var dict = [String: String]()
        var total: Double = 0
        for meal in self {
            total += meal.price
        }
        dict["price"] = String(total)
        var namesArr = [String]()
        for i in self {
            namesArr.append(i.name)
        }
        let orderList = namesArr.joined(separator: ", ")
        dict["orderList"] = orderList
        
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .short
        format.timeZone = .none
        format.dateStyle = .long
        format.locale = Locale(identifier: "en_US_POSIX")
        print(format.string(from: mytime))
        
        let DateAsString = format.string(from: mytime)
        dict["date"] = DateAsString
        return dict
    }
}
