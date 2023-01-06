
import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        let profileImage = UIImage(systemName: "person.crop.circle")?.withTintColor(.white)
        image = profileImage
        
    }
}
