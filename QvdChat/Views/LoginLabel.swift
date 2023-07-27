import UIKit

class LoginLabel: UILabel {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
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
        font = UIFont.SFProDisplayMedium
        font = self.font.withSize(30)
    }
}
