//
//  UIImageView + Extension.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 19.07.2023.
//

import Foundation
import FirebaseStorage
import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(imageName: String) {
        StorageManager.shared.getImageURL(for: imageName) { url in
            if url != nil {
                self.sd_setImage(with: url)
            }
        }
    }
}
