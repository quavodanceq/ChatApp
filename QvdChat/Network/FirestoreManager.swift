import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


class FirestoreManager {
    
    private init() {}
    
    static var shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection(FirestoreCollection.users.rawValue)
    }
    
    func checkEmail(email: String, completion: @escaping (LoginTextFieldError?) -> Void) {
        
        let auth = Auth.auth()
        
        auth.signIn(withEmail: email, password: "123123kksmrzh") { result, error in
            guard error != nil else {return completion(nil)}
            if error!.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                completion(.accountNotFound)
            }
            else if error!.localizedDescription == "The email address is badly formatted." {
                completion(.emailIsBadlyFormatted)
                
            }
            else {
                completion(nil)
            }
            
        }
    }
    
    
    func changeUsername(newUsername: String, completion: @escaping (LoginTextFieldError?) -> Void)  {
        guard isValidUsername(Input: newUsername) else {completion(.invalidUsername); return}
        isUsernameIsAlreadyTaken(username: newUsername) { taken in
            
            if taken {
                
                completion(.usernameIsAlreadyTaken)
            } else {
                AlgoliaManager.shared.changeUsername(username: newUsername)
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let userRef = self.usersRef.document(uid)
                let data = [FirestoreField.username.rawValue : newUsername.lowercased()]
                userRef.updateData(data) { error in
                    if error != nil {
                        completion(.unexpectedError)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func isUsernameIsAlreadyTaken(username: String, completion: @escaping (Bool) -> Void ) {
        
        usersRef.whereField(FirestoreField.username.rawValue, isEqualTo: username.lowercased()).getDocuments { snapshot, error in
            guard error == nil else {return completion(true)}
            completion(!snapshot!.isEmpty)
        }
    }
    
    func isValidUsername(Input:String) -> Bool {
        
        let RegEx = "\\w{6,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    func loadUserData(user: User, completion: @escaping (UserModel?) -> Void){
        
        usersRef.document(user.uid).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                var userModel = UserModel(document: snapshot)
                StorageManager.shared.getAvatar(userUID: user.uid) { avatarData in
                    if avatarData != nil {
                        userModel?.avatarData = avatarData
                    }
                    completion(userModel)
                }
                
            } else {
                completion(nil)
            }
        }
    }
    
    func isUsernameEntered(completion: @escaping (Bool) -> Void) {
        
        usersRef.document(Auth.auth().currentUser!.uid).getDocument { snapshot, error in
            if let snapshot = snapshot {
                let data = snapshot.data()
                if data![FirestoreField.username.rawValue] != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    
    func sendMessage(currentUser: UserModel,companion: UserModel, message: MessageModel, completion: @escaping (Error?) -> Void) {
        
        let companionRef = usersRef.document(companion.uid!).collection(FirestoreCollection.chats.rawValue).document(currentUser.uid!)
        
        let companionMessagesRef = companionRef.collection(FirestoreCollection.messages.rawValue)
        
        let myRef = usersRef.document(currentUser.uid!).collection(FirestoreCollection.chats.rawValue).document(companion.uid!)
        
        let myMessagesRef = myRef.collection(FirestoreCollection.messages.rawValue)
        
        let companionChatRepresentation = Chat(companionUsername: currentUser.username,
                                               companionUID: currentUser.uid!,
                                               lastMessageContent: message.content)
        
        let myChatRepresentation = Chat(companionUsername: companion.username,
                                        companionUID: companion.uid!,
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
                    
                case .modified:
                    
                    if let index = returnChats.firstIndex(where: {
                        $0.companionUID == chat.companionUID
                    }) {
                        returnChats.remove(at: index)
                        returnChats.insert(chat, at: 0)
                    }
                    break
                    
                case .added:
                    guard !returnChats.contains(chat) else {return}
                    returnChats.append(chat)
                    
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



