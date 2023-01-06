

import UIKit
import Foundation
import MessageKit
import FirebaseAuth
import Firebase
import Realm
import RealmSwift

class RegisterViewController: UIViewController {
    
    var registerError: String?
    
    private let emailLabel = LoginLabel(text: "Email")
    
    private let emailTextField = LoginTextField(placeholder: "Email", isSecure: false)
    
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
    
    private let usernameLabel = LoginLabel(text: "Username")
    
    private let usernameTextField = LoginTextField(placeholder: "Username", isSecure: false)
    
    private lazy var usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
    
    private let passwordLabel = LoginLabel(text: "Password")
    
    private let passwordTextField = LoginTextField(placeholder: "Password", isSecure: true)
    
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
    
    private let signUpButton = CustomButton(text: "Sign up")
    
    private var activityIndicator = UIActivityIndicatorView()
    
    
    private var email: String{
        get{
            return emailTextField.text ?? ""
        }
    }
    
    private var password: String{
        get{
            return passwordTextField.text ?? ""
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        super.setupNavigatonBar(title: "Sign up")
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        setupEmailStackView()
        setupUsernameStackView()
        setupPasswordStackView()
        setupSignUpButton()
    }
    private func setupEmailStackView() {
        emailStackView.spacing = 15
        emailStackView.axis = .vertical
        view.addSubview(emailStackView)
    }
    
    
    private func setupUsernameStackView() {
        usernameStackView.spacing = 15
        usernameStackView.axis = .vertical
        view.addSubview(usernameStackView)
    }
    private func setupPasswordStackView() {
        passwordStackView.spacing = 15
        passwordStackView.axis = .vertical
        view.addSubview(passwordStackView)
    }
    
    private func setupSignUpButton() {
        
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    private func setupActivityIndicatorView() {
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(origin: view.center, size: CGSize(width: 0, height: 0))
        activityIndicator.color = .white
    }
    
    
    private func setupConstraints(){
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            emailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            emailStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            usernameStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 25),
            usernameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            usernameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            passwordStackView.topAnchor.constraint(equalTo: usernameStackView.bottomAnchor, constant: 25),
            passwordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 50),
            signUpButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            signUpButton.heightAnchor.constraint(equalTo: signUpButton.widthAnchor, multiplier: 0.2),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc private func signUpButtonTapped() {
        
        activityIndicator.startAnimating()
        
        let newUser = FirestoreUserModel(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", email: emailTextField.text ?? "", uid: "")
        
        AuthSession.shared.register(newUser: newUser) { error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription, style: .destructive)
                self.activityIndicator.stopAnimating()
            } else {
                self.navigationController?.popViewController(animated: true)
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
}






