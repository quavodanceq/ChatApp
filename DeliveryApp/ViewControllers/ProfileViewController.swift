//
//  ProfileViewController.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 22.07.2023.
//

import Foundation
import UIKit
import SnapKit
import GoogleSignIn
import Firebase
import FirebaseAuth



class ProfileViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    private let mainLabel = UILabel()
    
    private let loginButton = GIDSignInButton()
    
    private let logOutButton = CustomButton(title: "Log out", foregroundColor: .white, backgroundColor: .customPurple)
    
    private let ordersListLabel = UILabel()
    
    private let ordersTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var orders = [OrderModel]()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        if Auth.auth().currentUser != nil {
            setupViews(userState: .loggedIn)
            ordersTableView.reloadData()
        } else {
            setupViews(userState: .loggedOut)
        }
    }
    
    override func viewWillLayoutSubviews() {
        ordersTableView.snp.makeConstraints { make in
            make.height.equalTo(ordersTableView.contentSize.height)
        }
    }
    
    private func setupViews(userState: UserState) {
        switch userState {
        case .loggedIn:
            setupNavigationBar()
            setupOrdersTableView()
            setupLogOutButton()
            setupConstraintsIfUserLoggedIn()
        case .loggedOut:
            navigationController?.navigationBar.isHidden = true
            setupImageView()
            setupLabel()
            setupButton()
            setupConstraintsIfUserIsNotLoggedIn()
        }
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        let displayName = Auth.auth().currentUser?.displayName
        navigationController?.navigationBar.topItem?.title = "Hello, \(displayName!)"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.backgroundColor = .customPurple
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupImageView() {
        
        imageView.image = UIImage(named: "ProfilePlaceholderImage")
        imageView.tintColor = .customPurple
        view.addSubview(imageView)
    }
    
    private func setupLabel() {
        
        mainLabel.text = "Hello!"
        mainLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        view.addSubview(mainLabel)
    }
    
    private func setupButton() {
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    private func setupConstraintsIfUserIsNotLoggedIn() {
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(imageView.snp.width)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
        }
        
        ordersTableView.snp.removeConstraints()
        logOutButton.isHidden = true
        logOutButton.snp.removeConstraints()
    }
    
    private func setupOrdersTableView() {
        
        view.addSubview(ordersTableView)
        ordersTableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        FirebaseManager.shared.fetchOrders { orders in
            self.orders = orders
            self.ordersTableView.reloadData()
            self.ordersTableView.snp.updateConstraints { make in
                make.height.equalTo(self.ordersTableView.contentSize.height)
            }
        }
    }
    
    private func setupLogOutButton() {
        
        view.addSubview(logOutButton)
        logOutButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 10, trailing: 7)
        logOutButton.configuration?.attributedTitle = AttributedString("Log out", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 22)!]))
        logOutButton.addTarget(self, action: #selector(logOutButtonTappeed), for: .touchUpInside)
    }
    
    private func setupConstraintsIfUserLoggedIn() {
        
        logOutButton.isHidden = false
        
        logOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.05)
            make.centerX.equalToSuperview()
        }
        
        ordersTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(logOutButton.snp.top)
        }
        
        loginButton.snp.removeConstraints()
        
        mainLabel.snp.removeConstraints()
        
        imageView.snp.removeConstraints()
    }
    
    @objc private func loginButtonTapped() {
        
        AuthManager.shared.login(viewController: self) { result in
            if result == .success {
                self.viewDidLoad()
            }
        }
    }
    
    @objc private func logOutButtonTappeed() {
        AuthManager.shared.logOut()
        viewDidLoad()
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = orders[indexPath.row]
        let cell = OrderCell(ord: order)
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        view.frame.height / 8
    }
}
