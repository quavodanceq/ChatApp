//
//  Message.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 10.09.2022.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var _partition: String = ""

    @Persisted var email: String = ""

    @Persisted var memberOf: List<Chat>

    @Persisted var name: String = ""
    
}
