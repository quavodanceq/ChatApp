//
//  NavigationButton.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 05.07.2023.
//

import Foundation
import UIKit
import SnapKit

class NavigationMenu: UIScrollView {
    
    private let pizzaButton = CustomButton(title: "Pizza", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private let sushiButton = CustomButton(title: "Kebab", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private let burgersButton = CustomButton(title: "Burgers", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private let drinksButton = CustomButton(title: "Drinks", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private let snacksButton = CustomButton(title: "Snacks", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private let desertsButton = CustomButton(title: "Deserts", foregroundColor: .customGray, backgroundColor: .buttonBackgroundColor)
    
    private lazy var buttons = [pizzaButton,sushiButton,burgersButton,snacksButton, drinksButton,desertsButton]
    
    var buttonDelegate: NavigationButtonDelegate?
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (str: String) {
        self.init()
        setupStackView()
        setupConstaints()
        setupButtons()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        showsHorizontalScrollIndicator = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.addArrangedSubview(pizzaButton)
        stackView.addArrangedSubview(sushiButton)
        stackView.addArrangedSubview(burgersButton)
        stackView.addArrangedSubview(snacksButton)
        stackView.addArrangedSubview(desertsButton)
        stackView.addArrangedSubview(drinksButton)
        stackView.alignment = .center
        addSubview(stackView)
    }
    
    private func setupConstaints() {

        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        for button in buttons {
            button.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }
    }
    
    private func setupButtons() {
        
        pizzaButton.addTarget(self, action: #selector(pizzaButtonTapped), for: .touchUpInside)
        sushiButton.addTarget(self, action: #selector(sushiButtonTapped), for: .touchUpInside)
        burgersButton.addTarget(self, action: #selector(burgersButtonTapped), for: .touchUpInside)
        drinksButton.addTarget(self, action: #selector(drinksButtonTapped), for: .touchUpInside)
        desertsButton.addTarget(self, action: #selector(desertsButtonTapped), for: .touchUpInside)
        snacksButton.addTarget(self, action: #selector(snacksButtonTapped), for: .touchUpInside)
    }
    
    @objc private func pizzaButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .pizza)
    }
    
    @objc private func sushiButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .kebab)
    }
    
    @objc private func burgersButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .burgers)
    }
    
    @objc private func drinksButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .drinks)
    }
    
    @objc private func desertsButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .deserts)
    }
    
    @objc private func snacksButtonTapped() {
        
        buttonDelegate?.buttonPressed(buttonType: .snacks)
    }
}

protocol NavigationButtonDelegate {
    
    func buttonPressed(buttonType: mealType)
}


