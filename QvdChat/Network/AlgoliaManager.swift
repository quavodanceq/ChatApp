import Foundation
import AlgoliaSearchClient
import FirebaseAuth

class AlgoliaManager {
    
    private init() {}
    
    private let client = SearchClient(appID: "6O3S5J58ZB", apiKey: "f447451567a5ccf850bee4ffb8f9a818")
    
    private lazy var index = client.index(withName: "users")
    
    static var shared = AlgoliaManager()
    
    func addUser(user: UserModel, completion: @escaping (Error?) -> Void) {
        
        let indexing = try? index.saveObject(user).wait(completion: { result in
            
            switch result {
            case .failure(let error):
                completion(error)
                print(error)
            case .success(_):
                completion(nil)
                break
            }
        })
    }
    
    func changeUsername(username: String) {
        
        let objectID = Auth.auth().currentUser!.uid
        index.partialUpdateObject(withID: "\(objectID)", with: .update(attribute: "username", value: "\(username.lowercased())")) { result in
            if case .success(let response) = result {
                print("Response: \(response)")
            }
        }
    }
    
    func search(username: String, completion: @escaping ([UserModel]) -> Void) {
        
        var query = Query(stringLiteral: username)
        index.search(query: "\(username)") { result in
            if case .success(let response) = result {
                do {
                    let hits: [UserModel] = try response.extractHits()
                    completion(hits)
                } catch let error {
                    print("Hits decoding error :\(error)")
                    completion([UserModel]())
                }
            } else {
                completion([UserModel]())
            }
        }
    }
    
}
