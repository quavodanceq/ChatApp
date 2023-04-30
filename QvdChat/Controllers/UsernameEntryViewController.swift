//
//  UsernameEntryViewController.swift
//  QvdChat
//
//  Created by Куат Оралбеков on 26.04.2023.
//

import UIKit

class UsernameEntryViewController: UIViewController {
    
    private let mainLabel = LoginLabel(text: "Last step")
    
    private let additionalLabel = LoginLabel(text: "Enter username")
    
    private let textField = CustomTextField(placeholder: "Username")
    
    private let usernameRulesLabel = UILabel()
    
    private let logInButton = CustomButton(text: "Continue")
    
    private let progressView = ProgressView(lineWidth: 100)
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        mainLabel,
        additionalLabel,
        textField,
        usernameRulesLabel,
        logInButton
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupStackViewElements()
        setupUsernameRulesLabel()
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
    
    private func setupUsernameRulesLabel() {
        usernameRulesLabel.text = "You can use a-z, 0-9 and underscores. Minimum length is 5 characters."
        usernameRulesLabel.textColor = .gray
        usernameRulesLabel.font = usernameRulesLabel.font.withSize(15)
        usernameRulesLabel.numberOfLines = 0
    }
    
    private func setupStackViewElements() {
        additionalLabel.font = additionalLabel.font.withSize(15)
        additionalLabel.textColor = .gray
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func setupButton() {
        logInButton.deactivate()
        logInButton.addTarget(self, action: #selector(LogInButtonTapped), for: .touchUpInside)
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
    
    @objc private func LogInButtonTapped() {
        logInButton.zoomInWithEasing()
        progressView.isAnimating = true
        guard let username = textField.text else {return}
        FirestoreManager.shared.changeUsername(newUsername: username) { error in
            if error == nil{
                self.progressView.isAnimating = false
            } else {
                self.progressView.isAnimating = false
                self.textField.showErrorLabel(errorType: error!)
            }
        }
    }
    
    @objc private func editingChanged() {
        if FirestoreManager.shared.isValidUsername(Input: textField.text ?? "") {
            logInButton.activate()
        } else {
            textField.showErrorLabel(errorType: .invalidUsername)
            logInButton.deactivate()
        }
    }

}
