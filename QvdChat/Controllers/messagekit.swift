//
//  messagekit.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 06.01.2023.
//

import Foundation

import MessageKit

class NewViewController: MessagesViewController {
    
}

extension NewViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        <#code#>
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        <#code#>
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        <#code#>
    }
    
    
}

extension NewViewController: MessagesDisplayDelegate {
    
}

extension NewViewController: MessagesLayoutDelegate {
    
}
