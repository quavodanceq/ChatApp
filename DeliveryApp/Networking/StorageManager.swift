//
//  StorageManager.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 19.07.2023.
//

import Foundation
import FirebaseStorage

class StorageManager {
    
    private let storage = Storage.storage()
    
    private lazy var storageRef = storage.reference()
    
    static let shared = StorageManager()
    
    func getImageURL(for imageName: String, completion: @escaping (URL?) -> Void) {
        
        let imageRef = storageRef.child("\(imageName).png")
        
        imageRef.downloadURL { result in
            switch result {
                
            case .success(let url):
                completion(url)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
