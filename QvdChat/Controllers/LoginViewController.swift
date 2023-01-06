

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    private let emailLabel = LoginLabel(text: "Email")
    
    private let emailTextField = LoginTextField(placeholder: "Email", isSecure: false)
    
    private lazy var emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
    
    private let passwordLabel = LoginLabel(text: "Password")
    
    private let passwordTextField = LoginTextField(placeholder: "Password", isSecure: true)
    
    private lazy var passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
    
    private let signInButton = CustomButton(text: "Sign in")
    
    private let registerLabel = LoginLabel(text: "Don't have an account?")
    
    private let registerButton = UIButton()
    
    private lazy var registerStackView = UIStackView(arrangedSubviews: [registerLabel, registerButton])
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Sign in"
        navigationItem.hidesBackButton = true
        super.setupNavigatonBar(title: "Login to Qvd Chat")
        setupViews()
    }
    private func setupViews() {
        
        view.backgroundColor = .black
        setupEmailStackView()
        setupPasswordStackView()
        setupSignInButton()
        setupRegisterStackView()
        setupActivityIndicatorView()
        setupConstraints()
        setupActivityIndicatorView()
    }
    
    private func setupEmailStackView() {
        
        emailStackView.spacing = 15
        emailStackView.axis = .vertical
        view.addSubview(emailStackView)
    }
    
    private func setupPasswordStackView() {
        
        passwordStackView.spacing = 15
        passwordStackView.axis = .vertical
        view.addSubview(passwordStackView)
    }
    
    private func setupSignInButton() {
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    private func setupRegisterStackView() {
        
        registerStackView.axis = .horizontal
        registerStackView.spacing = 5
        registerButton.setTitle("Sign up", for: .normal)
        registerButton.setTitleColor(.customGray, for: .normal)
        registerButton.titleLabel?.font = .appleSDGothicNeo?.withSize(20)
        registerButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(registerStackView)
    }
    
    private func setupActivityIndicatorView() {
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(origin: view.center, size: CGSize(width: 0, height: 0))
        activityIndicator.color = .white
    }
     
    private func setupConstraints() {
        
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            emailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            emailStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            passwordStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 50),
            passwordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 50),
            signInButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            signInButton.heightAnchor.constraint(equalTo: signInButton.widthAnchor, multiplier: 0.2),
            signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        registerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            registerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func signInButtonTapped() {
        activityIndicator.startAnimating()
        AuthSession.shared.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
                
            case .success(let user):
                let mainTabBarVC = MainTabBarViewController(user: user)
                self.navigationController?.pushViewController(mainTabBarVC, animated: true)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
                self.activityIndicator.stopAnimating()
            }
            
        }
      
        
        
        
    }
    
    @objc private func signUpButtonTapped() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

    


