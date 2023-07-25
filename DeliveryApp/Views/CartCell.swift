//
//  MealDescriptionLabel.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 17.07.2023.
//

import Foundation
import UIKit
import SnapKit

class CartCell: UITableViewCell {
    
    private var meal: Meal
    
    private let mealImageView = UIImageView()
    
    private let mealNameLabel = UILabel()
    
    private let mealPriceLabel = UILabel()
    
    let removeFromCartButton = CustomButton(title: "Remove", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        self.meal = Meal(name: "", description: "", imageName: "", price: 0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(meal: Meal) {
        
        self.init()
        self.meal = meal
        setupImageView()
        setupNameLabel()
        setupPriceLabel()
        setupButton()
        setupConstraints()
    }
    
    private func setupImageView() {
        
        contentView.addSubview(mealImageView)
        mealImageView.setImage(imageName: meal.imageName)
    }
    
    private func setupNameLabel() {
        
        contentView.addSubview(mealNameLabel)
        mealNameLabel.text = meal.name
        mealNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
    }
    
    private func setupPriceLabel() {
        
        contentView.addSubview(mealPriceLabel)
        mealPriceLabel.text = "\(meal.price)$"
        mealPriceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    }
    
    private func setupButton() {
        
        contentView.addSubview(removeFromCartButton)
        removeFromCartButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        removeFromCartButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        mealImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(mealImageView.snp.height)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mealImageView.snp.centerY)
            make.leading.equalTo(mealImageView.snp.trailing).offset(20)
        }
        
        mealPriceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalTo(mealImageView.snp.centerX)
        }
        
        removeFromCartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func removeButtonTapped(sender: UIButton) {
        
        CartManager.shared.removeFromCart(meal)
    }
}
