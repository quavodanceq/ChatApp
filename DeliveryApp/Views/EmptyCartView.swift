//
//  EmptyCartView.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 22.07.2023.
//

import Foundation
import UIKit
import SnapKit

class EmptyCartView: UIView {
    
    private let imageView = UIImageView()
    
    private let mainLabel = UILabel()
    
    private let additionLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupImageView()
        setupMainLabel()
        setupAdditionLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        self.init()
    }
    
    private func setupImageView() {
        
        addSubview(imageView)
        imageView.image = UIImage(named: "emptyCartPlaceholder")
    }
    
    private func setupMainLabel() {
        
        addSubview(mainLabel)
        mainLabel.textAlignment = .center
        mainLabel.text = "Oh, it's empty here"
        mainLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    }
    
    private func setupAdditionLabel() {
        
        addSubview(additionLabel)
        additionLabel.textAlignment = .center
        additionLabel.text = "Your shopping cart is empty, open the menu and select the product you like."
        additionLabel.numberOfLines = 0
        additionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        additionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func hide() {
        
        imageView.alpha = 0
        mainLabel.alpha = 0
        additionLabel.alpha = 0
    }
    
    func reveal() {
        
        imageView.alpha = 1
        mainLabel.alpha = 1
        additionLabel.alpha = 1
    }
}
