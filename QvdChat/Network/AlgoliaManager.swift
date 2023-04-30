

import Foundation
import AlgoliaSearchClient

class AlgoliaManager {
    
    private init() {}
    
    private let client = SearchClient(appID: "6O3S5J58ZB", apiKey: "f447451567a5ccf850bee4ffb8f9a818")
    
    private lazy var index = client.index(withName: "users")
    
    static var shared = AlgoliaManager()
    
    func addUser(user: UserModel) {
        
        let indexing = try? index.saveObject(user).wait(completion: { result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                break
            }
        })
    }
    

}
