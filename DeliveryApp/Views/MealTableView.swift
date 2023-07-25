//
//  MealTableView.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 14.07.2023.
//

import Foundation
import UIKit

class MealTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        isScrollEnabled = false
        separatorStyle = .none
        register(MealCell.self, forCellReuseIdentifier: "MealCell")
        backgroundColor = .customWhite
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
