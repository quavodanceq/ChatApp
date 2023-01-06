

import UIKit

class ChatCell: UITableViewCell {
    
    static let reuseIdentifier = "ChatCell"
    
    private let companionImageView = CircularImageView()
    private let companionNameLabel = UILabel()
    private let companionMessageLabel = UILabel()
    private lazy var nameAndMessageStack = UIStackView(arrangedSubviews: [companionNameLabel, companionMessageLabel])
    let dateLabel = UILabel()
    let messagesCountLabel = UILabel()
    private lazy var dateAndMessagesCountStack = UIStackView(arrangedSubviews: [dateLabel, messagesCountLabel])
    private lazy var chatInfoStack = UIStackView(arrangedSubviews: [nameAndMessageStack, dateAndMessagesCountStack])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        setupImageView()
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(companionName: String, companionMessage: String) {
        self.init()
        companionNameLabel.text = companionName
        companionMessageLabel.text = companionMessage
    }
    
    
    private func setupImageView() {
        contentView.addSubview(companionImageView)
        companionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            companionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            companionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            companionImageView.widthAnchor.constraint(equalTo: companionImageView.heightAnchor),
            companionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupChatInfoStack() {
        setupNameAndMessageStack()
        setupDateAndMessagesCountStack()
        chatInfoStack.axis = .horizontal
        chatInfoStack.distribution = .equalSpacing
        chatInfoStack.spacing = 5
        chatInfoStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatInfoStack)
        NSLayoutConstraint.activate([
            chatInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            chatInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            chatInfoStack.leadingAnchor.constraint(equalTo: companionImageView.trailingAnchor, constant: 12),
            chatInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupNameAndMessageStack() {
        nameAndMessageStack.translatesAutoresizingMaskIntoConstraints = false
        nameAndMessageStack.axis = .vertical
        nameAndMessageStack.distribution = .fillProportionally
        nameAndMessageStack.spacing = 5
        companionNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        companionNameLabel.textColor = .white
        companionMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        companionMessageLabel.textColor = .white
        companionMessageLabel.numberOfLines = 2
        companionMessageLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupDateAndMessagesCountStack() {
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        dateLabel.textColor = .gray
    }
    
    private func setupStack() {
        companionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companionMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndMessageStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameAndMessageStack)
        nameAndMessageStack.axis = .vertical
        nameAndMessageStack.distribution = .fill
        companionNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        companionNameLabel.textColor = .white
        companionMessageLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        companionMessageLabel.textColor = .white
        companionMessageLabel.numberOfLines = 1
        companionMessageLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            nameAndMessageStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameAndMessageStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            nameAndMessageStack.leadingAnchor.constraint(equalTo: companionImageView.trailingAnchor, constant: 12),
            nameAndMessageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            companionNameLabel.heightAnchor.constraint(equalTo: nameAndMessageStack.heightAnchor, multiplier: 0.5)
            
        ])
        
    }
    
}
