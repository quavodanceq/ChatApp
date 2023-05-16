//
//  RegisterButton.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 22.02.2023.
//

import Foundation
import UIKit

class SignUpButton: UIButton {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        
        self.init()
        setTitleColor(.white, for: .normal)
        setTitle(text, for: .normal)
        layer.cornerRadius = 13
        backgroundColor = .customGreen
        titleLabel?.font = .SFProDisplayMedium?.withSize(22)
        layer.cornerCurve = .continuous
        translatesAutoresizingMaskIntoConstraints = false
    }
}
