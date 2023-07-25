//
//  InfoViewController.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 17.07.2023.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    let meal: Meal
    
    private let mealImageView = UIImageView()
    
    private let mealNameLabel = UILabel()
    
    private let mealDescriptionLabel = UILabel()
    
    private let addToCartButton = CustomButton(title: "Add to cart", foregroundColor: .white, backgroundColor: .customPurple)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupAddToCartButton()
        setupConstraints()
    }
    

    init(meal: Meal) {
        
        self.meal = meal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        
        view.addSubview(mealImageView)
        mealImageView.setImage(imageName: meal.imageName)
    }
    
    private func setupNameLabel() {
        
        view.addSubview(mealNameLabel)
        mealNameLabel.text = meal.name
        mealNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
    }
    
    private func setupDescriptionLabel() {
        
        view.addSubview(mealDescriptionLabel)
        mealDescriptionLabel.text = meal.description
        mealDescriptionLabel.numberOfLines = 0
        mealDescriptionLabel.font = UIFont(name: "Thonburi", size: 20)
        mealDescriptionLabel.textColor = .black
    }
    
    private func setupAddToCartButton() {
        
        view.addSubview(addToCartButton)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        addToCartButton.configuration?.attributedTitle = AttributedString("Add to cart", attributes: AttributeContainer([NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 22)!]))
        addToCartButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    private func setupConstraints() {
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(mealImageView.snp.width)
            make.centerX.equalToSuperview()
            
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom)
            make.leading.equalToSuperview().offset(20)
        }
        
        mealDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func addToCartButtonTapped() {
        let cartManager = CartManager.shared
        cartManager.addToCart(meal)
        dismiss(animated: true)
    }
}
