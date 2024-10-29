//
//  PayScreenViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 23.10.2024.
//

import UIKit

final class PayScreenViewController: UIViewController {
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backward"), style: .plain, target: self, action: #selector(leftButtonTapped))
        button.tintColor = UIColor.blackCustom
        return button
    }()
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Pay.title", comment: "Выберите способ оплаты")
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .blackCustom
        return label
    }()
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreyCustom
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Pay.condition", comment: "Совершая покупку, вы соглашаетесь с условиями")
        label.textColor = .blackCustom
        label.font = .caption2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var payButton: UIButton = {
        let button = Button(title: NSLocalizedString("Pay.pay", comment: "Оплатить"), style: .normal, color: .blackCustom)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Pay.agreement", comment: "Пользовательского соглашения"), for: .normal)
        button.addTarget(self, action: #selector (bottomButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .caption2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var collection: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.register(PayScreenCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteCustom
        setupUI()
    }
    
    private func setupUI() {
        setupBackButton()
        setupTitle()
        setupBottomView()
        setupPayButton()
        setupBottomLabel()
        setupBottomButton()
        setupCollectionView()
    }
    
    private func setupTitle() {
        navigationItem.title = titleText.text
    }
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupPayButton() {
        bottomView.addSubview(payButton)
        
        payButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
        payButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
        payButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        
        bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 186).isActive = true
    }
    
    private func setupBottomLabel() {
        bottomView.addSubview(bottomLabel)
        
        bottomLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupBottomButton() {
        bottomView.addSubview(bottomButton)
        
        bottomButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
        bottomButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collection)
        
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        collection.heightAnchor.constraint(equalToConstant: 205).isActive = true
    }
    
    @objc func leftButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func bottomButtonTapped() {
        let webScreen = WebViewScreenViewController()
        let navController = webScreen.wrapWithNavigationController()
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true)
    }
    
    @objc func payButtonTapped() {
        //TODO: обработка запроса оплаты
    }
}

extension PayScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PayScreenCollectionViewCell {
            cell.setSelected(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PayScreenCollectionViewCell {
            cell.setSelected(false)
        }
    }
}

extension PayScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PayScreenCollectionViewCell = collection.dequeueReusableCell(indexPath: indexPath)
        cell.changeUI(number: indexPath.row)
        return cell
    }
    
}

extension PayScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 7
        let numberOfItemsPerRow: CGFloat = 2
        
        let availableWidth = collectionView.frame.width - totalSpacing * (numberOfItemsPerRow - 1)
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        return CGSize(width: itemWidth, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

