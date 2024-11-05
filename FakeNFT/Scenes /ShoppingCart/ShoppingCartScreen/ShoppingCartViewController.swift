//
//  ShoppingCartViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

protocol ShoppingCartView: AnyObject, ErrorView, LoadingView {
    func displayCells(_ cellModels: [ShoppingCartCellModel], price: Float, count: Int)
    func displayAlert(_ alert: UIAlertController)
    func presentCollection(on viewController: UIViewController)
    func deleteBlur()
    func reloadData()
}

final class ShoppingCartViewController: UIViewController {
    
    lazy var activityIndicator = UIActivityIndicatorView()
    private var presenter: ShoppingCartPresenter
    private var cellModels: [ShoppingCartCellModel] = []
    private var blurEffectView: UIVisualEffectView?
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreyCustom
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isHidden = true
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
        label.textColor = .blackCustom
        label.font = .caption1
        return label
    }()
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blackCustom
        label.text = NSLocalizedString("Cart.empty", comment: "Корзина пуста")
        label.font = .bodyBold
        label.isHidden = true
        return label
    }()
    private lazy var priceNFTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .greenUniversal
        label.font = .bodyBold
        return label
    }()
    private lazy var bottomButton: UIButton = {
        let button = Button(title: NSLocalizedString("Cart.pay", comment: "К оплате"), style: .normal, color: .blackCustom)
        if let titleLabel = button.titleLabel {
            titleLabel.font = .bodyBold
        }
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
        button.isHidden = true
        return button
    }()

    init(servicesAssembly: ServicesAssembly) {
        presenter = ShoppingCartPresenterImpl(servicesAssembly: servicesAssembly, nftService: servicesAssembly.nftService, orderService: servicesAssembly.orderService)
        super.init(nibName: nil, bundle: nil)
        presenter.setView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .whiteCustom
        setupBottomView()
        setupButton()
        setupCountNFT()
        setupPriceNFT()
        setupSortButton()
        setupTableView()
        setupEmptyLabel()
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
    
    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
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
        tableView.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: tableView)
    }
        
    @objc func showPayScreen() {
        presenter.didTapPayButton()
    }
    
    @objc func showActionSheet() {
        presenter.didTapSortButton()
    }
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTableViewCell = tableView.dequeueReusableCell()
        cell.accessoryType = .none
        let cellModel = cellModels[indexPath.row]
        cell.changeCell(with: cellModel)
        cell.parentController = self
        cell.delegate = self
        return cell
    }
}

extension ShoppingCartViewController: ShoppingCartView {
    func deleteBlur() {
        blurEffectView?.removeFromSuperview()
    }
    
    func reloadData() {
        presenter.reloadData()
    }

    
    func presentCollection(on viewController: UIViewController) {
        self.present(viewController, animated: true)
    }

    func displayCells(_ cellModels: [ShoppingCartCellModel], price: Float, count: Int) {
        
        if cellModels.count == 0 {
            bottomView.isHidden = true
            sortButton.isHidden = true
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
            bottomView.isHidden = false
            sortButton.isHidden = false
        }
        self.cellModels = cellModels
        tableView.reloadData()
        countNFTLabel.text = "\(count) NFT"
        priceNFTLabel.text = "\(price) NFT"
    }
    
    func displayAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}

extension ShoppingCartViewController: ShoppingCartCellProtocol {
    func didTapDeleteButton(in cell: CartTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let blurEffect = UIBlurEffect(style: .light)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView?.frame = self.view.bounds
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(blurEffectView!)
            presenter.didTapDeleteButton(on: indexPath)
        }
    }
}

extension ShoppingCartViewController {
    func presentScreen(view: UIViewController) {
        presentCollection(on: view)
    }
    
    
    
}
