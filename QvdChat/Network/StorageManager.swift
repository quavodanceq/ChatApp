import Foundation
import FirebaseStorage
import FirebaseAuth
import UIKit

class StorageManager {
    
    private let storage = Storage.storage()
    private lazy var storageRef = storage.reference()
    
    private init() {
        
    }
    
    static let shared = StorageManager()
    
    func changeAvatar(to image: Data, completion: @escaping (Result<Any, Error>) -> Void ) {
        
        let uid = Auth.auth().currentUser!.uid
        
        let avatarRef = storageRef.child("avatars/\(uid)/avatar.png")
        avatarRef.putData(image) { metadata, error in
            guard let metadata = metadata else { completion(.failure(error!))
                return }
            completion(.success(metadata))
        }
    }
    
    func getAvatar(userUID: String, completion: @escaping (Data?) -> Void) {
        
        let avatarRef = storageRef.child("avatars/\(userUID)/avatar.png")
        avatarRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                completion(data!)
            } 
        }
    }
    
    func getAvatar(stringUrl: String, completion: @escaping (Data?) -> Void) {
        
        let httpReference = storage.reference(forURL: stringUrl)
        httpReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                completion(data!)
            }
            
        }
    }
    
}
