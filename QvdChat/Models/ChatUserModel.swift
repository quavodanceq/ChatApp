//
//  UserModel.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 03.07.2022.
//
import Foundation
import UIKit
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    
    var displayName: String
}




