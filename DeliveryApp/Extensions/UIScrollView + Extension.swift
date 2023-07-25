//
//  UIScrollView + Extension.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 18.07.2023.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
}
