

import Foundation
import Realm
import RealmSwift

class SearchSession {
    
    private let usersRealm = try! Realm(configuration: .defaultConfiguration)
    
    static var shared = SearchSession()
    
    func search(username: String, completion: @escaping ([RealmUserModel]) -> Void) {
        
        let users = usersRealm.objects(RealmUserModel.self)
        
        let searchResult = users.where {
            $0.username.starts(with: username)
        }
        
        var foundUsers = [RealmUserModel]()
        
        for user in searchResult {
            foundUsers.append(user)
        }
        
        completion(foundUsers)
    }
}
