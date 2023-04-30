

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    private let label = LoginLabel(text: "Sign in")
    
    private let textField = CustomTextField(placeholder: "Email adress")
    
    private let logInButton = CustomButton(text: "Log in")
    
    private let orLabel = LoginLabel(text: "or")
    
    private let signUpButton = SignUpButton(text: "Sign up")
    
    private let progressView = ProgressView(lineWidth: 100)
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        label,
        textField,
        logInButton,
        orLabel,
        signUpButton
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Sign in"
        navigationItem.hidesBackButton = true
        setupStackView()
        setupStackViewElements()
        setupButtons()
        setupProgressView()
        setupConstraints()
    }
    private func setupStackView() {
        view.backgroundColor = .VkGray
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
    }
    
    private func setupStackViewElements() {
        orLabel.font = orLabel.font.withSize(15)
        orLabel.textColor = .gray
    }
    
    private func setupButtons() {
        logInButton.addTarget(self, action: #selector(LogInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
    }
     
    private func setupConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            logInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 50),
            progressView.widthAnchor.constraint(equalTo: progressView.heightAnchor)
        ])
        
        
        
    }
    
    @objc private func LogInButtonTapped() {
        
        logInButton.zoomInWithEasing()
        
        progressView.isAnimating = true
        
        guard !textField.text!.isEmpty else { textField.showErrorLabel(errorType: .emptyTextField); return }
        
        
        let email = textField.text
        
        DispatchQueue.global().async {
            
            FirestoreManager.shared.checkEmail(email: email!) { error in
                if error != nil{
                    DispatchQueue.main.async {
                        self.progressView.isAnimating = false
                        self.textField.showErrorLabel(errorType: error!)
                    }
                } else {
                    self.progressView.isAnimating = false
                    let viewController = PasswordEntryViewController(email: email!, type: .login)
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            
        
        
//            FirestoreManager.shared.checkEmail(email: email!) { exist in
//
//                if exist{
//
//                    let viewController = PasswordEntryViewController(email: email!)
//
//                    self.navigationController?.pushViewController(viewController, animated: true)
//
//                } else {
//                    DispatchQueue.main.async {
//                        self.textField.showErrorLabel(errorType: .accountNotFound)
//                    }
//
//
//
//
//
//
//                }
//            }
            
            

        
        }
        
            
        
        
    }
    
    @objc private func signUpButtonTapped() {
        signUpButton.zoomInWithEasing()
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

