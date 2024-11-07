//
//  AuthorDetailsViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 30.10.2024.
//

import UIKit
import WebKit

final class AuthorDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let url: String
    
    // MARK: - UI
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward"), for: .normal)
        button.addTarget(self,
                         action: #selector(didTapBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        updateURL()
    }
}

    // MARK: - Private Functions

private extension AuthorDetailsViewController {
    
    @objc
    func didTapBackButton() {
        dismiss(animated: true)
    }
    
    func updateURL() {
        guard
            let url = URL(string: url)
        else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func setUp() {
        view.addSubviews([webView, backButton])
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 9),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
