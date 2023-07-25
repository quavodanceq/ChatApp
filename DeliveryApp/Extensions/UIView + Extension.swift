//
//  UIView + Extension.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 20.07.2023.
//

import Foundation
import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

