//
//  ViewController.swift
//  DeliveryApp
//
//  Created by Куат Оралбеков on 03.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let buttonsScrollView = NavigationMenu(str: "")
    
    private let pizzaView = MealView(meal: .pizza)
    
    private let pizzaTableView = MealTableView()
    
    private var pizza = [Meal]()
    
    private let kebabView = MealView(meal: .kebab)
    
    private let kebabTableView = MealTableView()
    
    private var kebab = [Meal]()
    
    private let burgerView = MealView(meal: .burgers)

    private let snacksView = MealView(meal: .snacks)

    private let desertsView = MealView(meal: .deserts)
    
    private let drinksView = MealView(meal: .drinks)
    
    private let drinksTableView = MealTableView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupNavigatonButtons()
        setupPizzaTableView()
        fetchPizza()
        fetchKebab()
        setupKebabTableView()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        
        pizzaTableView.snp.makeConstraints { make in
            make.height.equalTo(pizzaTableView.contentSize.height)
        }
        
        kebabTableView.snp.makeConstraints { make in
            make.height.equalTo(kebabTableView.contentSize.height)
        }
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(buttonsScrollView)
        contentView.addSubview(pizzaView)
        contentView.addSubview(pizzaTableView)
        contentView.addSubview(kebabView)
        contentView.addSubview(kebabTableView)
        contentView.addSubview(burgerView)
        contentView.addSubview(snacksView)
        contentView.addSubview(desertsView)
        contentView.addSubview(drinksView)
        contentView.addSubview(drinksTableView)
    }
    
    private func setupNavigatonButtons() {
        
        navigationItem.titleView = buttonsScrollView
        buttonsScrollView.buttonDelegate = self
    }
    
    private func setupPizzaTableView() {
        
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
    }
    
    private func setupKebabTableView() {
        
        kebabTableView.delegate = self
        kebabTableView.dataSource = self
    }
    
    private func fetchPizza() {
        
        FirebaseManager.shared.fetchKebab { kebab in
            self.kebab = kebab
            DispatchQueue.main.async {
                self.kebabTableView.reloadData()
            }
            self.kebabTableView.reloadData()
            self.kebabTableView.snp.updateConstraints { make in
                make.height.equalTo(self.kebabTableView.contentSize.height)
            }
        }
    }
    
    private func fetchKebab() {
        
        FirebaseManager.shared.fetchPizza { pizza in
            self.pizza = pizza
            self.pizzaTableView.reloadData()
            
            self.pizzaTableView.snp.updateConstraints { make in
                make.height.equalTo(self.pizzaTableView.contentSize.height)
            }
        }
    }

    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
            
        }
        
        buttonsScrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.04)
            
        }
        
        pizzaView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        pizzaTableView.snp.makeConstraints { make in
            make.top.equalTo(pizzaView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        
        kebabView.snp.makeConstraints { make in
            make.top.equalTo(pizzaTableView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        kebabTableView.snp.makeConstraints { make in
            make.top.equalTo(kebabView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        
        burgerView.snp.makeConstraints { make in
            make.top.equalTo(kebabTableView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        snacksView.snp.makeConstraints { make in
            make.top.equalTo(burgerView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        desertsView.snp.makeConstraints { make in
            make.top.equalTo(snacksView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        drinksView.snp.makeConstraints { make in
            make.top.equalTo(desertsView.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(pizzaView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        drinksTableView.snp.makeConstraints { make in
            make.top.equalTo(drinksView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ViewController: NavigationButtonDelegate {
    
    func buttonPressed(buttonType: mealType) {
        switch buttonType {
        case .pizza:
            scrollView.scrollToView(view: pizzaView, animated: true)
        case .kebab:
            scrollView.scrollToView(view: kebabView, animated: true)
        case .burgers:
            scrollView.scrollToView(view: burgerView, animated: true)
        case .deserts:
            scrollView.scrollToView(view: desertsView, animated: true)
        case .snacks:
            scrollView.scrollToView(view: snacksView, animated: true)
        case .drinks:
            scrollView.scrollToView(view: drinksView, animated: true)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pizzaTableView {
            return pizza.count
        }
        if tableView == kebabTableView {
            return kebab.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == kebabTableView {
            if let cell = kebabTableView.dequeueReusableCell(withIdentifier: "MealCell") as? MealCell {
                cell.meal = kebab[indexPath.row]
                cell.setup()
                return cell
            }
        }
        
        if tableView ==  pizzaTableView {
            if let cell = pizzaTableView.dequeueReusableCell(withIdentifier: "MealCell") as? MealCell {
                cell.meal = pizza[indexPath.row]
                cell.setup()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == pizzaTableView {
            let meal = pizza[indexPath.row]
            navigationController?.present(InfoViewController(meal: meal), animated: true)
        }
    }
}
