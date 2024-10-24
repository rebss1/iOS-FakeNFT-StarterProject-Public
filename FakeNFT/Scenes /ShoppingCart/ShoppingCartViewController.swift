//
//  ShoppingCartViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

final class ShoppingCartViewController: UIViewController {
    
    private var blurEffectView: UIVisualEffectView?
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreyCustom
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .whiteCustom
        return tableView
    }()
    private lazy var countNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 NFT"
        label.textColor = .blackCustom
        label.font = .caption1
        return label
    }()
    private lazy var priceNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 ETH"
        label.textColor = .greenUniversal
        label.font = .bodyBold
        return label
    }()
    private lazy var bottomButton: UIButton = {
        let button = Button(title: NSLocalizedString("Cart.pay", comment: "К оплате"), style: .normal, color: .blackCustom)
        button.addTarget(self, action: #selector(showPayScreen), for: .touchUpInside)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.tintColor = UIColor.blackCustom
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .whiteCustom
        setupBottomView()
        setupButton()
        setupCountNFT()
        setupPriceNFT()
        setupSortButton()
        setupTableView()
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
    
    private func setupSortButton() {
        view.addSubview(sortButton)
        sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func deleteBLur() {
        blurEffectView?.removeFromSuperview()
    }
    
    func presentScreen(image: UIImage){
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView!)
        let deleteScreen = DeleteScreenViewController(image: image)
        deleteScreen.parentController = self
        deleteScreen.modalPresentationStyle = .overCurrentContext
        present(deleteScreen, animated: true)
    }
    
    @objc func showPayScreen() {
        let payScreen = PayScreenViewController()
        let navController = payScreen.wrapWithNavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true)
    }
    
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: NSLocalizedString("Cart.sort", comment: "Сортировка"), message: nil, preferredStyle: .actionSheet)
        //TODO: Обработать сортировку данных с сервера
        let priceAction = UIAlertAction(title: NSLocalizedString("Cart.byPrice", comment: "По цене"), style: .default, handler: { _ in
        })
        let ratingAction = UIAlertAction(title: NSLocalizedString("Cart.byRaiting", comment: "По рейтингу"), style: .default, handler: { _ in
        })
        let nameAction = UIAlertAction(title: NSLocalizedString("Cart.byName", comment: "По названию"), style: .default, handler: { _ in
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cart.close", comment: "Закрыть"), style: .cancel, handler: nil)
        
        actionSheet.addAction(priceAction)
        actionSheet.addAction(ratingAction)
        actionSheet.addAction(nameAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 //TODO: Сделать обработку данных с сервера
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTableViewCell = tableView.dequeueReusableCell()
        cell.accessoryType = .none
        cell.parentController = self
        return cell
    }
}
