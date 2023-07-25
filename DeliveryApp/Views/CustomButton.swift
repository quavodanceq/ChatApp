//
//  NavigationButton.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 05.07.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init (title: String, foregroundColor: UIColor, backgroundColor: UIColor) {
        
        self.init()
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "Thonburi", size: 18)!]))
        config.baseForegroundColor = foregroundColor
        config.baseBackgroundColor = backgroundColor
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        config.cornerStyle = .capsule
        configuration = config
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

