//
//  ShoppingCartViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class ShoppingCartViewController: UIViewController {
    
    //let servicesAssembly: ServicesAssembly
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreyCustom
        return view
    }()
//    let tableView: UITableView = {
//       let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .whiteCustom
//        return tableView
//    }()
    let countNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 NFT"
        label.textColor = .blackCustom
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let priceNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 ETH"
        label.textColor = .greenUniversal
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    let bottomButton: Button = {
        let button = Button(title: NSLocalizedString("Cart.pay", comment: "К оплате"), style: .normal, color: .blackCustom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//    let sortButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(named: "sort"), for: .normal)
//        button.tintColor = UIColor.blackCustom
//        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        return button
//    }()
    
    
    init(servicesAssembly: ServicesAssembly) {
        //self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteCustom
        setupBottomView()
        setupButton()
        setupCountNFT()
        setupPriceNFT()
//        setupSortButton()
//        setupTableView()
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 76).isActive = true
    }
    
    private func setupButton() {
        bottomView.addSubview(bottomButton)
        bottomButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bottomButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    private func setupCountNFT() {
        bottomView.addSubview(countNFTLabel)
        countNFTLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        countNFTLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupPriceNFT() {
        bottomView.addSubview(priceNFTLabel)
        priceNFTLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16).isActive = true
        priceNFTLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
    }
//    private func setupSortButton() {
//        view.addSubview(sortButton)
//        sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
//    }
//    private func setupTableView() {
//        view.addSubview(tableView)
//        tableView.frame = self.view.bounds
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -20).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//    }
}

//extension ShoppingCartViewController: UITableViewDelegate {
//    
//}
//
//extension ShoppingCartViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UITableViewCell()
//    }
//    
//}
