

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import MessageKit

class FirestoreSession {
    
    static var shared = FirestoreSession()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection(FirestoreCollection.users.rawValue)
    }
    
    func loadUserData(user: User, completion: @escaping (FirestoreUserModel?) -> Void){
        usersRef.document(user.uid).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                let user = FirestoreUserModel(document: snapshot)
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    
    func sendMessage(currentUser: FirestoreUserModel,companion: RealmUserModel, message: MessageModel, completion: @escaping (Error?) -> Void) {
        let companionRef = usersRef.document(companion.uid).collection(FirestoreCollection.chats.rawValue).document(currentUser.uid)
        
        let companionMessagesRef = companionRef.collection(FirestoreCollection.messages.rawValue)
        
        let myRef = usersRef.document(currentUser.uid).collection(FirestoreCollection.chats.rawValue).document(companion.uid)
        
        let myMessagesRef = myRef.collection(FirestoreCollection.messages.rawValue)
        
        let companionChatRepresentation = Chat(companionUsername: currentUser.username,
                                               companionUID: currentUser.uid,
                                               lastMessageContent: message.content)
        
        let myChatRepresentation = Chat(companionUsername: companion.username,
                                        companionUID: companion.uid,
                                        lastMessageContent: message.content)
        
        companionRef.setData(companionChatRepresentation.representation) { error in
            if let error = error {
                completion(error)
            }
        }
        
        myRef.setData(myChatRepresentation.representation) { error in
            if let error = error {
                completion(error)
            }
        }
        
        companionMessagesRef.addDocument(data: message.representation) { error in
            if let error = error {
                completion(error)
            }
        }
        
        myMessagesRef.addDocument(data: message.representation) { error in
            if let error = error {
                completion(error)
            }
        }
        
        completion(nil)
        
    }
    
    
    
    func chatsListener(chats: [Chat], completion: @escaping (Result<[Chat],Error>) -> Void) -> ListenerRegistration? {
        var returnChats = chats
        let chatsRef = usersRef.document(Auth.auth().currentUser!.uid).collection(FirestoreCollection.chats.rawValue)
        let listener = chatsRef.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { change in
                guard let chat = Chat(document: change.document) else {return}
                
                switch change.type {
                    
                case .added:
                    guard !returnChats.contains(chat) else {return}
                    returnChats.append(chat)
                case .modified:
                    guard let index = returnChats.firstIndex(of: chat) else {return}
                    returnChats[index] = chat
                case .removed:
                    guard let index = returnChats.firstIndex(of: chat) else {return}
                    returnChats.remove(at: index)
                }
                
            }
            
            completion(.success(returnChats))
            
        }
        
        return listener
        
    }
    
    func messagesListener(chat: Chat, completion: @escaping (Result<MessageModel, Error>) -> Void) -> ListenerRegistration? {
        let messagesRef = usersRef.document(Auth.auth().currentUser!.uid).collection(FirestoreCollection.chats.rawValue).document(chat.companionUID).collection(FirestoreCollection.messages.rawValue)
        let listener = messagesRef.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { change in
                guard let message = MessageModel(document: change.document) else {return}
                
                switch change.type {
                    
                case .added:
                    completion(.success(message))
                    
                case .modified:
                    break
                case .removed:
                    break
                }
                
            }
            
            
        }
        return listener
    }
    
    
    
}


