//
//  FirebaseManager.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 19.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift


class FirebaseManager {
    
    private let firestore = Firestore.firestore()
    
    static let shared = FirebaseManager()
    
    func fetchPizza(completion: @escaping([Meal]) -> Void) {
        firestore.collection("pizza").getDocuments { snapshot, error in
            var meals = [Meal]()
            if snapshot != nil {
                for doc in snapshot!.documents {
                    let data = doc.data()
                    let meal = Meal(name: data["name"] as?
                                    String ?? "", description: data["description"] as? String ?? "", imageName: data["imageName"] as? String ?? "", price: data["price"] as? Double ?? 0)
                    meals.append(meal)
                }
            }
            completion(meals)
        }
    }
    
    func fetchKebab(completion: @escaping([Meal]) -> Void) {
        firestore.collection("kebab").getDocuments { snapshot, error in
            var meals = [Meal]()
            if snapshot != nil {
                for doc in snapshot!.documents {
                    let data = doc.data()
                    let meal = Meal(name: data["name"] as?
                                    String ?? "", description: data["description"] as? String ?? "", imageName: data["imageName"] as? String ?? "", price: data["price"] as? Double ?? 0)
                    meals.append(meal)
                }
            }
            completion(meals)
        }
    }
    
    
    
    func addOrder(order: [Meal], completion: @escaping (LoginResult) -> Void) {
        
        guard let user = Auth.auth().currentUser?.uid else { return completion(.failure)}
        do {
            try firestore.collection("users").document(user).collection("orders").document().setData(from: order.rep)
        }
        catch(let error) {
            print(error)
        }
        completion(.success)
    }
    
    func fetchOrders(completion: @escaping([OrderModel]) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        firestore.collection("users").document(userId).collection("orders").getDocuments { snapshot, error in
            if error == nil {
                var orders = [OrderModel]()
                snapshot!.documents.map({ document in
                    let data = document.data()
                    let order = OrderModel(orderList: data["orderList"] as! String, orderPrice: data["price"] as! String, orderDate: data["date"] as! String)
                    print(order)
                    orders.append(order)
                })
                completion(orders)
            }
        }
    }
    
}

