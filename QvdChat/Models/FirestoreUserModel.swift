

import Foundation
import FirebaseFirestore

struct FirestoreUserModel {
    
    var username: String
    
    var password: String
    
    var email: String
    
    var uid: String
    
    init? (document: DocumentSnapshot) {
        guard let data = document.data() else {return nil}
        let username = data[FirestoreField.username.rawValue] as! String
        let email = data[FirestoreField.email.rawValue] as! String
        let uid = data[FirestoreField.uid.rawValue] as! String
        
        self.username = username
        self.email = email
        self.uid = uid
        self.password = ""
        
    }
    
    init (username: String, password: String, email: String, uid: String) {
        self.username = username
        self.password = password
        self.email = email
        self.uid = uid
    }
    
}


