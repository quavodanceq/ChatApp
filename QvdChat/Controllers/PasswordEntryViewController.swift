//
//  PasswordEntryViewController.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 12.04.2023.
//

import UIKit

class PasswordEntryViewController: UIViewController {
    
    private let email: String
    
    private let mainLabel = LoginLabel(text: "Enter password")
    
    private let additionalLabel: LoginLabel
    
    private let textField = CustomTextField(placeholder: "Password", isSecure: true)
    
    private let logInButton = CustomButton(text: "Continue")
    
    private let progressView = ProgressView(lineWidth: 100)
    
    private let type: ViewControllerType
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        mainLabel,
        additionalLabel,
        textField,
        logInButton
    ])
    
    init(email: String, type: ViewControllerType) {
        
        self.type = type
       
        self.email = email
        
        switch type {
        case .registration:
            self.additionalLabel = LoginLabel(text: "That will be linked to \(email)")
        case .login:
            self.additionalLabel = LoginLabel(text: "Linked to \(email)")
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupStackViewElements()
        setupButton()
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
        additionalLabel.font = additionalLabel.font.withSize(15)
        additionalLabel.textColor = .gray
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func setupButton() {
        logInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        logInButton.deactivate()
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
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
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 50),
            progressView.widthAnchor.constraint(equalTo: progressView.heightAnchor)
        ])
        
    }
    
    @objc private func editingChanged(sender: UITextField) {
        if sender.text?.count == 0 {
            logInButton.deactivate()
        } else {
            logInButton.activate()
        }
    }
    
    @objc private func loginButtonTapped() {
        
        logInButton.zoomInWithEasing()
        
        progressView.isAnimating = true
        
        let password = textField.text!
        
        switch type {
        case .registration:
            
            DispatchQueue.global().async {
                
                AuthManager.shared.register(email: self.email, password: password) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.progressView.isAnimating = false
                            let usernameEntry = UsernameEntryViewController()
                            self.navigationController?.pushViewController(usernameEntry, animated: true)
                        }
                    } else {
                        self.progressView.isAnimating = false
                        self.textField.showErrorLabel(errorType: error!)
                    }
                }
            
                
            }
            
        case .login:
            DispatchQueue.global().async {
            
                AuthManager.shared.login(email: self.email, password: password) { result in
                    switch result{
                        
                    case .success(let user):
                        self.progressView.isAnimating = false
                        let chatsVC = ChatsViewController(currentUser: user)
                        self.navigationController?.pushViewController(chatsVC, animated: true)
                    case .failure(let error):
                        if error == .usernameIsNotEntered {
                            let usernameEntry = UsernameEntryViewController()
                            self.navigationController?.pushViewController(usernameEntry, animated: true)
                        } else {
                        DispatchQueue.main.async {
                            self.progressView.isAnimating = false
                            self.textField.showErrorLabel(errorType: .incorrectPassword)
                        }
                        }
                    }
                }
            }
        }
        
        
        
        
        
    }
    
    

}

enum ViewControllerType {
    
    case registration
    
    case login
    
}
