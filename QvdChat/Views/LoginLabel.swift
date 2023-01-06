
import UIKit

class LoginLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
        setup()
    }
    
    private func setup(){
        textColor = .white
        font = UIFont.appleSDGothicNeo
    }
}
