

import Foundation
import MessageKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



struct MessageModel: MessageType {
    var sender: SenderType
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var sentDate: Date
    
    var kind: MessageKind {
        return .text(content)
    }
    
    var id: String?
    
    var content: String
    
    
    var representation: [String : Any] {
        return [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
    }
    
    init(user: UserModel, content: String) {
        self.content = content
        sender = Sender(senderId: user.uid!, displayName: user.username)
        sentDate = Date()
        id = nil
        
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let content = data[FirestoreField.content.rawValue] as? String else {return nil}
        guard let created = data[FirestoreField.created.rawValue] as? Timestamp else {return nil}
        guard let senderID = data[FirestoreField.senderID.rawValue] as? String else {return nil}
        guard let senderName = data[FirestoreField.senderName.rawValue] as? String else {return nil}
        
        self.content = content
        self.sentDate = created.dateValue()
        self.sender = Sender(senderId: senderID, displayName: senderName)
    }
    
}

extension MessageModel: Comparable {
    static func < (lhs: MessageModel, rhs: MessageModel) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
    
    static func == (lhs: MessageModel, rhs: MessageModel) -> Bool {
        lhs.sentDate == rhs.sentDate
    }
    
    
}




