

import UIKit

class CustomTextField: UITextField {
    
    private let floatingLabel = UILabel(frame: CGRect.zero)
    
    private let button = UIButton()
    
    private lazy var errorLabel = UILabel(frame: CGRect.zero)
    
    private lazy var isErrorLabelIsHidden = true
    
    private let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String, isSecure: Bool = false) {
        self.init()
        isSecureTextEntry = isSecure
        if isSecureTextEntry{
            font = .systemFont(ofSize: 20)
        }else{
            font = .SFProDisplayBold?.withSize(22)
        }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.VkTextFieldTextColor, NSAttributedString.Key.font: UIFont.SFProDisplayBold?.withSize(22)])
        setup()
    }
    
    private func setup() {
        backgroundColor = .VkTextFieldColor
        tintColor = .white
        textColor = .white
        layer.cornerRadius = 13
        layer.cornerCurve = .continuous
        layer.borderWidth = 1
        layer.borderColor = UIColor.VkTextFieldBorderColor.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        setupButton()
        self.addTarget(self, action: #selector(editingSelector), for: .allEditingEvents)
    }
    
    private func setupButton() {
        if isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            rightViewMode = .whileEditing
            rightView = button
            button.addTarget(self, action: #selector(changeSecureness), for: .touchUpInside)
        } else {
            button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            rightViewMode = .whileEditing
            rightView = button
            button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        }
        
    }
    
    private func setupErrorLabel() {
        errorLabel.textColor = .red
        errorLabel.font = UIFont.SFProDisplayMedium?.withSize(14)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.frame = CGRect(origin: .zero, size: CGSize(width: self.frame.size.width, height: 14))
    }
    
    
    func showErrorLabel(errorType: LoginTextFieldError) {
        switch errorType {
        case .accountNotFound:
            errorLabel.text = "Account not found"
        case .emptyTextField:
            errorLabel.text = "Email required"
        case .incorrectPassword:
            errorLabel.text = "Incorrect password"
        case .emailIsBadlyFormatted:
            errorLabel.text = "Email is badly formatted"
        case .invalidUsername:
            errorLabel.text = "Invalid username"
        case .usernameIsAlreadyTaken:
            errorLabel.text = "Username is already taken"
        case .unexpectedError:
            errorLabel.text = "Unexpected error"
        case .emailIsAlreadyInUse:
            errorLabel.text = "Email is already in use"
        case .passwordIsBadlyFormatted:
            errorLabel.text = "The password must be 6 characters long or more"
        }
        isErrorLabelIsHidden = false
        setupErrorLabel()
        addSubview(errorLabel)
        self.errorLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.errorLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = false
        self.errorLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -5).isActive = true
        self.errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        layer.borderColor = UIColor.red.cgColor
        
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
                
            }
        
        
        
    }
    
    
    
    private func hideErrorLabel() {
        isErrorLabelIsHidden = true
        errorLabel.removeFromSuperview()
        layer.borderColor = UIColor.VkTextFieldBorderColor.cgColor
    }
    
    @objc private func changeSecureness() {
        if isSecureTextEntry{
            isSecureTextEntry = false
        } else {
            isSecureTextEntry = true
        }
    }
    
    @objc private func clearButtonTapped() {
        text?.removeAll()
        if !isErrorLabelIsHidden {
            hideErrorLabel()
        }
    }
    
    @objc private func editingSelector() {
        if !isErrorLabelIsHidden {
            hideErrorLabel()
        }
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


