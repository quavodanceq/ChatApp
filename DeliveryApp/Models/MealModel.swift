//
//  MealModel.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 11.07.2023.
//

import Foundation
import UIKit

struct Meal: Codable {
    
    let name: String
    
    let description: String
    
    let imageName: String
    
    let price: Double
    
    var representation: [String: Any] {
        return ["name": name,
                "description": description,
                "price": price,
                "imageName": imageName
        ]
    }
}

enum mealType {
    
    case pizza
    case kebab
    case burgers
    case drinks
    case deserts
    case snacks
}

extension Meal: Equatable {
    
}


