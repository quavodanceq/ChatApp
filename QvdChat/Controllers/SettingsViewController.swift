

import UIKit

class SettingsViewController: UIViewController {
    
    private let currentUser: UserModel
    
    private let avatarView = CircularImageView()
    
    private let logOutButton = CustomButton(text: "Log out")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setupAvatarView()
        setuplogOutButton()
        setupConstraints()
    }
    
    init(currentUser: UserModel) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAvatarView() {
        view.addSubview(avatarView)
        
    }
    
    private func setuplogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            logOutButton.heightAnchor.constraint(equalTo: logOutButton.widthAnchor, multiplier: 0.2)
        ])
    }
    
    @objc private func logOutButtonTapped() {
        if AuthManager.shared.logOut() {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}
