//
//  MealCell.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 09.07.2023.
//

import UIKit
import SnapKit

class MealCell: UITableViewCell {
    
    var meal: Meal?
    
    private let mealImageView = UIImageView()
    
    private let mealNameLabel = UILabel()
    
    private let mealDescriptionLabel = UILabel()
    
    private var mealPriceButton: CustomButton
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        mealPriceButton = CustomButton()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    convenience init(meal: Meal) {
        
        self.init()
        addSubview(mealImageView)
        addSubview(mealNameLabel)
        addSubview(mealDescriptionLabel)
        mealImageView.backgroundColor = .orange
        mealNameLabel.text = meal.name
        mealDescriptionLabel.text = meal.description
        mealPriceButton = CustomButton(title: "\(meal.price)$", foregroundColor: .white, backgroundColor: .customPurple)
        setupConstraints()
        sizeToFit()
    }
    
    func setup() {
        
        backgroundColor = .customWhite
        setupImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupPriceButton()
        setupConstraints()
    }
    
    private func setupImageView() {
        
        addSubview(mealImageView)
        mealImageView.setImage(imageName: meal!.imageName)
        mealImageView.layer.borderWidth = 0
        mealImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupNameLabel() {
        
        addSubview(mealNameLabel)
        mealNameLabel.text = meal?.name
        mealNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
    }
    
    private func setupDescriptionLabel() {
        
        addSubview(mealDescriptionLabel)
        mealDescriptionLabel.text = meal?.description
        mealDescriptionLabel.font = UIFont(name: "Thonburi", size: 13)
        mealDescriptionLabel.textColor = .customGray
        mealDescriptionLabel.numberOfLines = 0
        mealDescriptionLabel.sizeToFit()
    }
    
    private func setupPriceButton() {
        
        mealPriceButton = CustomButton(title: "\(meal?.price ?? 0)$", foregroundColor: .white, backgroundColor: .customPurple)
        addSubview(mealPriceButton)
    }
    
    
    private func setupConstraints() {
        
        mealImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(mealImageView.snp.width)
        }
        
        mealNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(mealImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        mealDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom)
            make.leading.equalTo(mealNameLabel.snp.leading)
            make.trailing.equalTo(mealNameLabel.snp.trailing)
        }

        mealPriceButton.snp.makeConstraints { make in
            make.leading.equalTo(mealNameLabel.snp.leading)
            make.top.equalTo(mealDescriptionLabel.snp.bottom).offset(10)
        }
    }
}
