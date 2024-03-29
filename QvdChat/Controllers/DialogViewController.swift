import UIKit
import MessageKit
import Foundation
import InputBarAccessoryView
import Firebase
import FirebaseAuth
import FirebaseFirestore

class DialogViewController: MessagesViewController {
    
    private let currentUser: UserModel
    
    private let companion: UserModel
    
    private var messages: [MessageModel] = []
    
    private var messagesListener: ListenerRegistration?
    
    init(currentUser: UserModel, companion: UserModel, chat: Chat?) {
        
        self.currentUser = currentUser
        self.companion = companion
        super.init(nibName: nil, bundle: nil)
        if let chat = chat {
            messagesListener = FirestoreManager.shared.messagesListener(chat: chat, completion: { result in
                switch result {
                    
                case .success(let message):
                    self.insertNewMessage(message: message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        
        messagesListener?.remove()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupLayout()
        setupDelegates()
        setupInputBar()
        if currentUser.uid == companion.uid {
            title = "Saved messages"
        } else {
            title = companion.username
        }
    }
    
    private func setupLayout() {
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            
            layout.textMessageSizeCalculator.incomingAvatarSize = .init(width: 30, height: 30)
        }
        
        messagesCollectionView.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupInputBar() {
        
        messageInputBar.inputTextView.layer.cornerRadius = 20
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 7, bottom: 10, right: 10)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        messageInputBar.inputTextView.placeholderLabel.text = "Message"
        messageInputBar.inputTextView.backgroundColor = .black
        messageInputBar.backgroundView.backgroundColor = .customGray
        messageInputBar.inputTextView.textColor = .white
    }
    
    private func setupDelegates() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    private func insertNewMessage(message: MessageModel) {
        
        guard !messages.contains(message) else {return}
        messages.append(message)
        messages.sort()
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem()
    }

    
}

extension DialogViewController: MessagesDataSource {

    func numberOfSections(
        in messagesCollectionView: MessagesCollectionView
    ) -> Int {
        
        return messages.count
    }
    
    
    func currentSender() -> SenderType {
        
        return Sender(senderId: currentUser.uid!, displayName: currentUser.username)
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func messageTopLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath
    ) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ])
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        if indexPath.section % 4 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            return nil
        }
        
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        if indexPath.section % 4 == 0 {
            return 30
        } else {
            return 0
        }
    }
    
    
}
extension DialogViewController: MessagesDisplayDelegate, MessagesLayoutDelegate, InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = MessageModel(user: currentUser, content: text)
        FirestoreManager.shared.sendMessage(currentUser: currentUser, companion: companion, message: message) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.messagesCollectionView.scrollToLastItem()
                if self.messagesListener == nil {
                    print("no message listener")
                    let chat = Chat(companionUsername: self.companion.username,
                                    companionUID: self.companion.uid!,
                                    lastMessageContent: message.content)
                    self.messagesListener = FirestoreManager.shared.messagesListener(chat: chat, completion: { result in
                        switch result {
                            
                        case .success(let message):
                            self.insertNewMessage(message: message)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            }
        }
        self.messagesCollectionView.reloadData()
        inputBar.inputTextView.text = ""
        
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.setAvatar(userUID: companion.uid!)
        avatarView.isHidden = isNextMessageSameSender(at: indexPath)
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        
        guard indexPath.section + 1 < messages.count else { return false }
        return messages[indexPath.section].sender.displayName == messages[indexPath.section + 1].sender.displayName
    }
    
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        return .bubble
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        .customGray
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        .white
    }
    
    
    
}
