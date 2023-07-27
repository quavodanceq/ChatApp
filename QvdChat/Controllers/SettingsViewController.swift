import UIKit
import SDWebImage
import FirebaseStorage
import FirebaseStorageUI

class SettingsViewController: UIViewController {
    
    private let currentUser: UserModel
    
    private let avatarView = CircularImageView()
    
    private let logOutButton = CustomButton(text: "Log out")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
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
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarViewTapped))
        avatarView.addGestureRecognizer(tapGesture)
        avatarView.isUserInteractionEnabled = true
        avatarView.setAvatarImage()
        
    }
    
    private func setupNavigation() {
        title = "Settings"
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .customGray
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .customGray
        navigationController?.navigationBar.backgroundColor = .customGray
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    
    private func setuplogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            logOutButton.heightAnchor.constraint(equalTo: logOutButton.widthAnchor, multiplier: 0.2)
        ])
    }
    
    @objc private func avatarViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    @objc private func logOutButtonTapped() {
        if AuthManager.shared.logOut() {
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let loginVC = LoginViewController()
                let navigationVC = UINavigationController(rootViewController: loginVC)
                scene.setRootViewController(navigationVC)
            }
        }
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        dismiss(animated: true)
        StorageManager.shared.changeAvatar(to: data) { result in
            switch result {
            case .success(_):
                self.avatarView.setAvatarImage()
            case .failure(_):
                break
            }
        }
    }
}

extension SettingsViewController: UINavigationControllerDelegate {
    
}
