
import Foundation
import RealmSwift
import Realm
import FirebaseAuth
import Firebase

import Network

class AuthSession {
    
    static var shared = AuthSession()
    
    private let db = Firestore.firestore()
    
    private let usersRealm = try! Realm(configuration: .defaultConfiguration)
    
    private let auth = Auth.auth()
    
    func register(newUser: FirestoreUserModel, completion: @escaping (Error?) -> ()) {
        
        validateUsername(username: newUser.username) { error in
            if let error = error {
                completion(error)
            } else {
                self.auth.createUser(withEmail: newUser.email, password: newUser.password) { [weak self] result, error in
                    if let error = error {
                        completion(error)
                    } else {
                        let newRealmUser = RealmUserModel()
                        newRealmUser.username = newUser.username
                        newRealmUser.uid = result!.user.uid
                        try? self!.usersRealm.write({
                            self!.usersRealm.add(newRealmUser)
                        })
                        
                        let usersRef = self!.db.collection(FirestoreCollection.users.rawValue)
                        let userData = [FirestoreField.username.rawValue: newUser.username,
                                        FirestoreField.email.rawValue: newUser.email,
                                        FirestoreField.uid.rawValue: result!.user.uid]
                        
                        usersRef.document(result!.user.uid).setData(userData) { error in
                            if let error = error {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping (_ result : Result<FirestoreUserModel, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                FirestoreSession.shared.loadUserData(user: result!.user) { user in
                    if let user = user {
                        completion(.success(user))
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
    
    private func validateUsername(username: String, completion: @escaping (Error?)->Void) {
        guard username != "" else {return completion(CustomError.enterUsername)}
        let users = usersRealm.objects(RealmUserModel.self)
        let sameUsername = users.where {
            $0.username.equals(username.lowercased(), options: .caseInsensitive)
        }
        if sameUsername.count == 0 {
            completion(nil)
        } else {
            completion(CustomError.usernameIsAlreadyTaken)
        }
    }
    
}

