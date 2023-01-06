
import UIKit
import FirebaseAuth

class MainTabBarViewController: UITabBarController {
    
    private let currentUser: FirestoreUserModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAppearance()
    }
    
    init(user: FirestoreUserModel) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewControllers() {
        navigationItem.hidesBackButton = true
        let chatsVcImage = UIImage(systemName: "message.fill")
        let settingsVcImage = UIImage(systemName: "gear")
        let chatsVC = UINavigationController(rootViewController: ChatsViewController(currentUser: currentUser))
        let settingsVC = UINavigationController(rootViewController: SettingsViewController(currentUser: currentUser))
        chatsVC.tabBarItem.title = "Chats"
        settingsVC.tabBarItem.title = "Settings"
        chatsVC.tabBarItem.image = chatsVcImage
        settingsVC.tabBarItem.image = settingsVcImage
        setViewControllers([chatsVC, settingsVC], animated: false)
    }
    
    private func setupAppearance() {
        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().backgroundColor = .customGray
    }
    
}


