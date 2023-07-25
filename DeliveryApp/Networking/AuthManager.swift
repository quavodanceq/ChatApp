//
//  AuthManager.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 24.07.2023.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase
import UIKit

class AuthManager {
    
    static let shared = AuthManager()
    
    func login(viewController : UIViewController, completion: @escaping (LoginResult) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if result != nil {
                    completion(.success)
                } else {
                    completion(.failure)
                }
            }
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
