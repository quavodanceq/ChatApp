import Foundation

enum FirestoreField: String {
    case username = "username"
    case name = "name"
    case surname = "surname"
    case uid = "uid"
    case aboutUser = "aboutUser"
    case users = "users"
    case email = "email"
    case companionUsername = "companionUsername"
    case companionUID = "companionUID"
    case lastMessageContent = "lastMessageContent"
    case content = "content"
    case created = "created"
    case senderID = "senderID"
    case senderName = "senderName"
}

enum FirestoreCollection: String {
    case chats = "chats"
    case users = "users"
    case messages = "messages"
}
