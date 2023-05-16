

import Foundation
import UIKit
import MessageKit
import FirebaseFirestore

struct Chat{
    
    var companionUsername: String
    
    var companionUID: String
    
    var lastMessageContent: String
    
    var companionAvatar: UIImage?
    
    var representation: [String : Any] {
        
        return [
            "companionUsername": companionUsername,
            "companionUID": companionUID,
            "lastMessageContent": lastMessageContent
        ]
    }
    
    init? (document: DocumentSnapshot) {
        
        guard let data = document.data() else {return nil}
        guard let username = data[FirestoreField.companionUsername.rawValue] as? String else {return nil}
        guard let uid = data[FirestoreField.companionUID.rawValue] as? String else {return nil}
        guard let lastMessageContent = data[FirestoreField.lastMessageContent.rawValue] as? String else {return nil}
        
        self.companionUsername = username
        self.companionUID = uid
        self.lastMessageContent = lastMessageContent
                
    }
    
    init(companionUsername: String, companionUID: String, lastMessageContent: String) {
        
        self.companionUsername = companionUsername
        self.companionUID = companionUID
        self.lastMessageContent = lastMessageContent
    }
}

extension Chat: Equatable {
    
}



