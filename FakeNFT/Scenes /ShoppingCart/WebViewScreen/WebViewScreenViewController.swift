//
//  WebViewScreenViewController.swift
//  FakeNFT
//
//  Created by Вадим Дзюба on 23.10.2024.
//

import UIKit
import WebKit

final class WebViewScreenViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView = {
        var web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    private var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backward"), style: .plain, target: nil, action: nil)
        button.tintColor = UIColor.blackCustom
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        startLoadingWeb()
    }
    
    private func setupUI() {
        setupBackButton()
        setupWebView()
    }
    
    private func startLoadingWeb() {
        if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setupBackButton() {
        navigationItem.leftBarButtonItem = backButton
        backButton.target = self
        backButton.action = #selector(goBack)
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func goBack() {
        dismiss(animated: true)
    }
}
