//
//  BasketViewController.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 18.07.2023.
//

import Foundation
import UIKit
import SnapKit
import Combine

class CartViewController: UIViewController {
    
    var cart = [Meal]()
    
    var totalPrice: Double = 0
    
    var cancellable = [AnyCancellable]()
    
    private let emptyCartView = EmptyCartView()
    
    private let priceLabel = UILabel()
    
    private let mealsTableView = UITableView()
    
    private let makeOrderButton = CustomButton(title: "Make order", foregroundColor: .white, backgroundColor: .customPurple)
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupEmptyCartView()
        setupPriceLabel()
        setupMealsTableView()
        setupMakeOrderButton()
        setupConstraints()
        setupPublisher()
    }

    private func setupPublisher() {
        
        UserDefaults.standard.publisher(for: \.observableMealsData)
            .map{ data -> [Meal] in
                guard let data = data else { return [] }
                return (try? JSONDecoder().decode([Meal].self, from: data)) ?? []
            }.sink { meals in
                
                self.cart = meals
                if self.cart.isEmpty {
                    self.tabBarItem.badgeValue = nil
                    self.emptyCartView.reveal()
                    self.emptyCartView.isHidden = false
                    self.mealsTableView.isHidden = true
                    self.priceLabel.isHidden = true
                    self.makeOrderButton.isHidden = true
                    
                } else {
                    self.tabBarItem.badgeValue = String(self.cart.count)
                    self.emptyCartView.isHidden = true
                    self.mealsTableView.isHidden = false
                    self.priceLabel.isHidden = false
                    self.makeOrderButton.isHidden = false
                    
                    var price: Double = 0
                    for meal in self.cart {
                        price += meal.price
                    }
                    let total = Double(Int(price * 100)) / 100
                    self.totalPrice = total
                    self.priceLabel.text = "\(self.cart.count) items for worth \(self.totalPrice)$"
                    self.mealsTableView.reloadData()
                }
            }.store(in: &cancellable)
    }
    
    private func setupEmptyCartView() {
        
        view.addSubview(emptyCartView)
        emptyCartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(view.snp.width).multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupMakeOrderButton() {
        
        makeOrderButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 10, trailing: 7)
        makeOrderButton.configuration?.attributedTitle = AttributedString("Make order", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 22)!]))
        makeOrderButton.addTarget(self, action: #selector(makeOrderButtonTapped), for: .touchUpInside)
        view.addSubview(makeOrderButton)
    }
    
    private func setupPriceLabel() {
        
        priceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        view.addSubview(priceLabel)
    }
    
    private func setupMealsTableView() {
        
        mealsTableView.allowsSelection = false
        mealsTableView.dataSource = self
        mealsTableView.delegate = self
        mealsTableView.separatorStyle = .none
        view.addSubview(mealsTableView)
    }
    
    private func setupConstraints() {
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        makeOrderButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        mealsTableView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(makeOrderButton.snp.top)
        }
    }
    
    @objc private func makeOrderButtonTapped() {
        FirebaseManager.shared.addOrder(order: cart) { result in
            switch result {
            case .success:
                
                CartManager.shared.removeCart()
                self.dismiss(animated: true)
            case .failure:
                let alert = UIAlertController(title: "Oops!", message: "It looks like you haven't logged in", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true)
            }
        }
        
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartCell(meal: cart[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
}




