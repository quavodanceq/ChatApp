import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        
        self.init()
        setTitleColor(.black, for: .normal)
        setTitle(text, for: .normal)
        layer.cornerRadius = 13
        backgroundColor = .white
        titleLabel?.font = .SFProDisplayMedium?.withSize(22)
        layer.cornerCurve = .continuous
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func deactivate() {
        
        self.layer.opacity = 0.5
        self.isEnabled = false
    }
    
    func activate() {
        
        self.layer.opacity = 1
        self.isEnabled = true
    }
    
    
    
}
