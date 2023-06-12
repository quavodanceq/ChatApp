import UIKit
import FirebaseStorageUI
import FirebaseStorage
import FirebaseAuth

class CircularImageView: UIImageView {

    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        tintColor = .white
    }
    
    func setAvatarImage() {
        
        guard let uid = Auth.auth().currentUser?.uid  else { return }
        let avatarRef = Storage.storage().reference().child("avatars/\(uid)/avatar.png")
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
    
    func setAvatarImage(userUID: String) {
        
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

