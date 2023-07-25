//
//  CartManager.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 18.07.2023.
//

import Foundation
import Combine

class CartManager {
    
    static let shared = CartManager()
    
    let userDefaults = UserDefaults.standard

    func addToCart(_ meal: Meal) {
        
        userDefaults.meals.append(meal)
    }

    func removeFromCart(_ meal: Meal) {
        
        let cart = userDefaults.meals
        guard let index = cart.firstIndex(of: meal) else {return}
        userDefaults.meals.remove(at: index)
    }
    
    func removeCart() {
        
        userDefaults.meals = [Meal]()
    }
}
