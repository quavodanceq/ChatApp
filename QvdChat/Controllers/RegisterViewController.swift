

import UIKit
import Foundation


class RegisterViewController: UIViewController {
    
    private let mainLabel = LoginLabel(text: "Enter email")
    
    private let textField = CustomTextField(placeholder: "Email")
    
    private let continueButton = CustomButton(text: "Continue")
    
    private let progressView = ProgressView(lineWidth: 100)
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        mainLabel,
        textField,
        continueButton
    ])
    
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
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func setupButton() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        continueButton.deactivate()
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
            continueButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
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
            continueButton.deactivate()
        } else {
            continueButton.activate()
        }
    }
    
    @objc private func continueButtonTapped() {
        
        continueButton.zoomInWithEasing()
        
        progressView.isAnimating = true
        
        let email = textField.text!
        
        FirestoreManager.shared.checkEmail(email: email) { error in
            switch error {
            case .none:
                self.progressView.isAnimating = false
                self.textField.showErrorLabel(errorType: .emailIsAlreadyInUse)
            case .some(let error):
                if error == .accountNotFound {
                    self.progressView.isAnimating = false
                    let passwordEntry = PasswordEntryViewController(email: email, type: .registration)
                    self.navigationController?.pushViewController(passwordEntry, animated: true)
                } else {
                    self.progressView.isAnimating = false
                    self.textField.showErrorLabel(errorType: error)
                }
                
                //        DispatchQueue.global().async {
                //
                //            AuthManager.shared.login(email: self.email, password: password) { result in
                //                switch result{
                //
                //                case .success(let user):
                //                    let chatsVC = ChatsViewController(currentUser: user)
                //                    self.navigationController?.pushViewController(chatsVC, animated: true)
                //                case .failure(_):
                //
                //                    DispatchQueue.main.async {
                //                        self.textField.showErrorLabel(errorType: .incorrectPassword)
                //                    }
                //
                //                }
                //            }
                //        }
                
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
}
