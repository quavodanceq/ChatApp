//
//  MealView.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 14.07.2023.
//

import UIKit
import SnapKit

class MealView: UIView {
    
    var meal: Meal?
    
    let rectangleView = UIView()
    
    let mealImageView = UIImageView()
    
    let mealNameLabel = UILabel()
    
    let mealDescriptionLabel = UILabel()
    
    var mealPriceButton: CustomButton

    override init(frame: CGRect) {
        
        mealPriceButton = CustomButton()
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(meal: mealType) {
        
        self.init()
        
        switch meal {
            
        case .pizza:
            
            let meal = Meal(name: "Pizza Four seasons", description: "Mozzarella, chicken ham, chicken pepperoni, cheese cubes, tomatoes, mushrooms, tomato sauce, Italian herbs", imageName: "pizza", price: 10.99)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        case .kebab:
            
            let meal = Meal(name: "Meat kebab", description: "Hot appetizer with chicken, meatballs, spicy chorizo sausages, mozzarella cheese and burger sauce in a thin wheat tortilla", imageName: "meat kebab", price: 7.49)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        case .burgers:
            
            let meal = Meal(name: "Cheeseburger", description: "Cheeseburger with beef patty, lettuce, tomatoes, Gouda cheese and signature sauce", imageName: "cheezeburger", price: 7.99)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        case .deserts:
            
            let meal = Meal(name: "Maffin", description: "Natural cocoa, and inside there is a delicate filling of white and milk chocolate cubes", imageName: "maffin", price: 9.99)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        case .snacks:
            
            let meal = Meal(name: "lunchbox with wings", description: "Hot hearty lunch of chicken wings with spices and the aroma of smoked potatoes from the oven and barbecue sauce", imageName: "lunchbox w wing", price: 8.99)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        case .drinks:
            
            let meal = Meal(name: "Coffee Caramel capuchino", description: "If not chocolate, then caramel! And cappuccino with caramel syrup is especially good", imageName: "caramel capuchino", price: 3.99)
            mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
            self.meal = meal
        }
        setup()
        setupConstraints()
    }
    
    func setup() {
        
        setupRectangleView()
        setupImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupPriceButton()
        setupTarget()
        setupConstraints()
    }
    
    private func setupRectangleView() {
        
        addSubview(rectangleView)
        rectangleView.layer.cornerCurve = .continuous
        rectangleView.layer.cornerRadius = 15
        rectangleView.layer.shadowColor = UIColor.black.cgColor
        rectangleView.layer.shadowRadius = 10
        rectangleView.layer.shadowOpacity = 0.1
        rectangleView.layer.shadowOffset = .zero
    }
    
    private func setupImageView() {
        
        addSubview(mealImageView)
        mealImageView.image = UIImage(named: meal!.imageName)
    }
    
    private func setupNameLabel() {
        
        addSubview(mealNameLabel)
        mealNameLabel.text = meal?.name
        mealNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
    }
    
    private func setupDescriptionLabel() {
        
        addSubview(mealDescriptionLabel)
        mealDescriptionLabel.text = meal?.description
        mealDescriptionLabel.font = UIFont(name: "Thonburi", size: 18)
        mealDescriptionLabel.textColor = .customGray
        mealDescriptionLabel.numberOfLines = 0
    }
    
    private func setupPriceButton() {
        
        addSubview(mealPriceButton)
    }
    
    private func setupTarget() {
        
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        gesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    func setupConstraints() {
        
        rectangleView.snp.makeConstraints { make in
            rectangleView.backgroundColor = .customWhite
            make.height.equalToSuperview().multipliedBy(0.75)
            make.width.equalTo(rectangleView.snp.height)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        mealImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(mealImageView.snp.height)
            
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        mealDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        mealPriceButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    @objc private func viewDidTapped() {
        
        self.parentViewController?.navigationController?.present(InfoViewController(meal: meal!), animated: true)
    }
}
