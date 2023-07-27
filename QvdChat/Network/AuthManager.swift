import Foundation
import FirebaseAuth
import Firebase
import Network
import AlgoliaSearchClient

class AuthManager {
    
    private init() {}
    
    static var shared = AuthManager()
    
    private lazy var db = Firestore.firestore()
    
    private let auth = Auth.auth()
    
    func register(email: String, password: String, completion: @escaping (LoginTextFieldError?) -> ()) {
        
        self.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                if error.localizedDescription == "The password must be 6 characters long or more." {
                    completion(.passwordIsBadlyFormatted)
                } else {
                    completion(.unexpectedError)
                }
                
            } else {
                
                var newUser = UserModel(email: result!.user.email!, uid: result!.user.uid, username: "")
                newUser.objectID = "\(result!.user.uid)"
                
                AlgoliaManager.shared.addUser(user: newUser) { error in
                    if error != nil {
                        completion(.unexpectedError)
                        return
                    }
                }
                let usersRef = self?.db.collection(FirestoreCollection.users.rawValue)
                let userData = [FirestoreField.email.rawValue: email.lowercased(),
                                FirestoreField.uid.rawValue: result!.user.uid]
                usersRef?.document(result!.user.uid).setData(userData) { error in
                    if let error = error {
                        completion(.unexpectedError)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        
    }
    
    
    
    func login(email: String, password: String, completion: @escaping (_ result : Result<UserModel, LoginError>) -> Void) {
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(.incorrectPassword))
            } else {
                FirestoreManager.shared.isUsernameEntered { entered in
                    if entered {
                        FirestoreManager.shared.loadUserData(user: result!.user) { user in
                            if let user = user {
                                completion(.success(user))
                            }
                        }
                    } else {
                        completion(.failure(.usernameIsNotEntered))
                    }
                }
                
            }
        }
    }
    
    func logOut() -> Bool{
        
        try? auth.signOut()
        if let user = auth.currentUser {
            return false
        } else {
            return true
        }
    }
    
}

