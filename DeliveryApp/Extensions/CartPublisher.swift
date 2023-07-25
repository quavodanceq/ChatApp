//
//  CartPublisher.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 25.07.2023.
//

import Foundation

extension UserDefaults {
    
    @objc dynamic private(set) var observableMealsData: Data? {
                get {
                    UserDefaults.standard.data(forKey: "cart")
                }
                set { UserDefaults.standard.set(newValue, forKey: "cart") }
            }
    
    var meals: [Meal]{
       get{
           guard let data = UserDefaults.standard.data(forKey: "cart") else { return [] }
           return (try? JSONDecoder().decode([Meal].self, from: data)) ?? []
       } set{
           observableMealsData = try? JSONEncoder().encode(newValue)
       }
    }
}
