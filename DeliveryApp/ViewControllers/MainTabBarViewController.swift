//
//  MainTabBarViewController.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 19.07.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let menuVC = ViewController()
    
    let cartViewController = CartViewController()
    
    let profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let MenuViewControllerWithNavigation = UINavigationController(rootViewController: menuVC)
        MenuViewControllerWithNavigation.tabBarItem.title = "Menu"
        MenuViewControllerWithNavigation.tabBarItem.image = UIImage(systemName: "menucard")
        cartViewController.tabBarItem.title = "Cart"
        cartViewController.tabBarItem.image = UIImage(systemName: "cart.fill")
        let profileViewControllerWithNavigation = UINavigationController(rootViewController: profileVC)
        profileViewControllerWithNavigation.tabBarItem.title = "Profile"
        profileViewControllerWithNavigation.tabBarItem.image = UIImage(systemName: "person.crop.rectangle")
        if !UserDefaults.standard.meals.isEmpty {
            cartViewController.tabBarItem.badgeValue = String(UserDefaults.standard.meals.count)
        }
        tabBar.tintColor = .customPurple
        setViewControllers([MenuViewControllerWithNavigation,
                            cartViewController,
                            profileViewControllerWithNavigation], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
