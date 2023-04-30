
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
                
                
                
                //AlgoliaManager.shared.addUser(user: newUser)
                
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
        
    
    
    func login(email: String, password: String, completion: @escaping (_ result : Result<UserModel, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                FirestoreManager.shared.loadUserData(user: result!.user) { user in
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
       
    }
    
    private func writeToAlgolia(user: UserModel){
        
        let client = SearchClient(appID: "6O3S5J58ZB", apiKey: "f447451567a5ccf850bee4ffb8f9a818")
        let index = client.index(withName: "users")
        
    }
    
}

