//
//  MyNftViewController.swift
//  FakeNFT
//
//  Created by Сергей Баскаков on 23.10.2024.
//

import UIKit
import ProgressHUD

protocol MyNFTViewControllerProtocol: AnyObject {
    
    func setLoader(visible: Bool)
    func refreshNfts(nfts: [MyNFT])
    func showError(_ model: ErrorModel)

}

final class MyNFTViewController: UIViewController {
    
    var presenter: MyNFTVPresenterProtocol?
    
    private var visibleNfts: [MyNFT] = []
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.action = #selector(close)
        button.target = self
        return button
    }()
    
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(
                named: "profileImages/sort"
            )?.withRenderingMode(.alwaysTemplate),
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        return button
    }()
    
    private lazy var myNFTTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .whiteUniversal
        table.delegate = self
        table.dataSource = self
        table.register(
            ProfileMyNFTTableCell.self,
            forCellReuseIdentifier: ProfileMyNFTTableCell.reuseIdentifier
        )
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var emptyNFTsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyBold
        label.textColor = .blackUniversal
        label.text = "У Вас ещё нет NFT"
        label.isHidden = true
        return label
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteUniversal
        tabBarController?.tabBar.isHidden = true
        setupNavBar()
        addElements()
        setupConstraints()
        
        presenter?.loadNfts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProgressHUD.dismiss()
        
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Private Methods
    @objc
    private func sortButtonTapped(){
        print("sort button tapped")
        showSortAlert()
        
    }
    
    @objc private func close() {
        print("closed")
        navigationController?.popViewController(animated: true)
        
    }
    
    func selectCell(cellIndex: Int) {
        
    }
    
    private func setupNavBar(){
        navigationItem.title = "Мои NFT"
        navigationItem.rightBarButtonItem = sortButton
        navigationItem.rightBarButtonItem?.tintColor = .blackUniversal
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .blackUniversal
    }
    
    private func addElements() {
        view.addSubview(myNFTTableView)
        view.addSubview(emptyNFTsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myNFTTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myNFTTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myNFTTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myNFTTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            emptyNFTsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyNFTsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func showSortAlert() {
        let alert = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "По цене",
                                      style: .default) { _ in
            
        })
        alert.addAction(UIAlertAction(
            title: "По рейтингу",
            style: .default
        ) { _ in
        })
        alert.addAction(UIAlertAction(
            title: "По названию",
            style: .default
        ) { _ in
        })
        alert.addAction(UIAlertAction(
            title: "Закрыть",
            style: .cancel
        ) { _ in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDataSource
extension MyNFTViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return visibleNfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileMyNFTTableCell.reuseIdentifier,
            for: indexPath
        ) as? ProfileMyNFTTableCell else {
            return ProfileMyNFTTableCell()
        }
        
        cell.configCell(visibleNfts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

//MARK: - UITableViewDelegate
extension MyNFTViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCell(cellIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - MyNFTControllerProtocol
extension MyNFTViewController: MyNFTViewControllerProtocol {
    
    func setLoader(visible: Bool) {
        visible ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
    
    
    func refreshNfts(nfts: [MyNFT]) {
        visibleNfts = nfts
        
        myNFTTableView.reloadData()
        
        if visibleNfts.isEmpty {
            emptyNFTsLabel.isHidden = false
            myNFTTableView.isHidden = true
            
            navigationItem.title = ""
            
        } else {
            emptyNFTsLabel.isHidden = true
            myNFTTableView.isHidden = false
            
            navigationItem.title = "Мои NFT"
        }
    }
}

// MARK: ErrorView
extension MyNFTViewController: ErrorView {
    
}




