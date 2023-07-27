import Foundation
import MessageKit
import SDWebImage
import FirebaseStorage

extension AvatarView {
    
    func setAvatar(userUID: String) {
        
        let avatarRef = Storage.storage().reference().child("avatars/\(userUID)/avatar.png")
        avatarRef.downloadURL { result in
            switch result {
                
            case .success(let url):
                print(url)
                self.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"), options: .refreshCached, completed: nil)
            case .failure(_):
                break
            }
        }
    }
}
