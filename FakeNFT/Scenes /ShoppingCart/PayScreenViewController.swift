//
//  PayScreenViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 23.10.2024.
//

import UIKit

final class PayScreenViewController: UIViewController {
    
    private var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backward"), style: .plain, target: nil, action: nil)
        button.tintColor = UIColor.blackCustom
        return button
    }()
    private var titleText: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Pay.title", comment: "Выберите способ оплаты")
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .blackCustom
        return label
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGreyCustom
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Pay.condition", comment: "Совершая покупку, вы соглашаетесь с условиями")
        label.textColor = .blackCustom
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var payButton: UIButton = {
        let button = Button(title: NSLocalizedString("Pay.pay", comment: "Оплатить"), style: .normal, color: .blackCustom)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Pay.agreement", comment: "Пользовательского соглашения"), for: .normal)
        button.addTarget(self, action: #selector (bottomButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    }
    
    private func setupTitle() {
        navigationItem.title = titleText.text
    }
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = backButton
        backButton.target = self
        backButton.action = #selector(leftButtonTapped)
    }
    
    private func setupPayButton() {
        bottomView.addSubview(payButton)
        
        payButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16).isActive = true
        payButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16).isActive = true
        payButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -16).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)

        bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 152).isActive = true
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
    
    @objc func leftButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func bottomButtonTapped() {
        let webScreen = WebViewScreenViewController()
        let navController = UINavigationController(rootViewController: webScreen)
        navController.modalPresentationStyle = .overCurrentContext
        present(navController, animated: true)
    }
    
    @objc func payButtonTapped() {
        //TODO: обработка запроса оплаты
    }
}
