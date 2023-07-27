
import Foundation
import Realm
import RealmSwift

class RealmUserModel: Object {
    
    @Persisted var username: String
    @Persisted var uid: String
    
}
