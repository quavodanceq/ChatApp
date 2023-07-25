//
//  OrderCell.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 23.07.2023.
//

import Foundation
import UIKit
import SnapKit

class OrderCell: UITableViewCell {
    
    private var order: OrderModel
    
    let mealsNameLabel = UILabel()
    
    let totalLabel = UILabel()
    
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        self.order = OrderModel(orderList: "", orderPrice: "", orderDate: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(ord: OrderModel) {

        self.init()
        self.order = ord
        setup()
    }

    func setup() {
        setupMealsLabel()
        setupTotalLabel()
        setupDateLabel()
        setupConstraints()
    }
    
    private func setupMealsLabel() {
        
        addSubview(mealsNameLabel)
        mealsNameLabel.text = order.orderList
        mealsNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    }
    
    private func setupTotalLabel() {
        
        addSubview(totalLabel)
        totalLabel.sizeToFit()
        totalLabel.text = "\(order.orderPrice)$"
        totalLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
    }
    
    private func setupDateLabel() {
        
        addSubview(dateLabel)
        dateLabel.sizeToFit()
        dateLabel.text = order.orderDate
        totalLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    }
    
    private func setupConstraints() {
        
        mealsNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(mealsNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
