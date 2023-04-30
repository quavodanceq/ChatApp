

import Foundation
import FirebaseFirestore
import AlgoliaSearchClient

struct UserModel: Equatable, Encodable {
    
    let username: String
    
    let email: String
    
    var uid: String?
    
    init? (document: DocumentSnapshot) {
        guard let data = document.data() else {return nil}
        let username = data[FirestoreField.username.rawValue] as! String
        let email = data[FirestoreField.email.rawValue] as! String
        let uid = data[FirestoreField.uid.rawValue] as! String
        let name = data[FirestoreField.name.rawValue] as! String
        
        self.username = username
        self.email = email
        self.uid = uid
    }
    
    init (username: String, email: String, uid: String? = nil) {
        self.username = username
        self.email = email

        self.uid = uid
    }
    
}



