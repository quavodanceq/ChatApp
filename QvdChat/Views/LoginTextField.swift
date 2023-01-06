

import UIKit

class LoginTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String, isSecure: Bool) {
        self.init()
        setup()
        isSecureTextEntry = isSecure
        if isSecureTextEntry{
            font = .systemFont(ofSize: 20)
        }else{
            font = .appleSDGothicNeo?.withSize(22)
        }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.appleSDGothicNeo?.withSize(22)])
    }
    
    private func setup() {
        backgroundColor = .customGray
        tintColor = .white
        textColor = .white
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
