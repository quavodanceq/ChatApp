import Foundation
import UIKit
import FirebaseFirestore
import AlgoliaSearchClient

struct UserModel: Equatable, Encodable, Decodable {
    
    let username: String
    
    let email: String?
    
    var uid: String?
    
    var objectID: ObjectID?
    
    var avatarData: Data?
    
    var photo: String?
            
    
    init? (document: DocumentSnapshot) {
        
        guard let data = document.data() else {return nil}
        let username = data[FirestoreField.username.rawValue] as! String
        let email = data[FirestoreField.email.rawValue] as! String
        let uid = data[FirestoreField.uid.rawValue] as! String
        
        self.username = username
        self.email = email
        self.uid = uid
    }
    
    init (email: String? = nil, uid: String,username: String) {
        
        self.username = username
        self.email = email
        self.uid = uid
    }
    
}


