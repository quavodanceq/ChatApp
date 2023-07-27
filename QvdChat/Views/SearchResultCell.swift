import UIKit

class SearchResultCell: UITableViewCell {
    
    static let reuseIdentifier = "ChatCell"
    
    private let companionImageView = CircularImageView()
    
    private let companionNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
    }
    
    convenience init(user: UserModel) {
        
        self.init()
        companionNameLabel.text = user.username
        companionImageView.setAvatarImage(userUID: user.uid ?? "")
        setupImageView()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func setupNameLabel() {
        
        contentView.addSubview(companionNameLabel)
        companionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companionNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        companionNameLabel.textColor = .white
        NSLayoutConstraint.activate([
            companionNameLabel.leadingAnchor.constraint(equalTo: companionImageView.trailingAnchor, constant: 12),
            companionNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
}
