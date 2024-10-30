//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 13.10.2024.
//

import UIKit

protocol CatalogView: AnyObject, ErrorView, LoadingView {
    func displayCells(_ cellModels: [CatalogCellModel])
    func displayAlert(_ alert: UIAlertController)
    func presentCollection(on viewController: UIViewController)
}

final class CatalogViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Private Properties
    
    private lazy var collectionWidth = collectionView.frame.width
    private let presenter: CatalogPresenter
    private var cellModels: [CatalogCellModel] = []
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CatalogCell.self)
        return collectionView
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.addTarget(self,
                         action: #selector(didTapSortButton),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    init(servicesAssembly: ServicesAssembly) {
        presenter = CatalogPresenterImpl(servicesAssembly: servicesAssembly)
        super.init(nibName: nil, bundle: nil)
        presenter.setView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriden Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }
}
    
    // MARK: - Private Methods
    
private extension CatalogViewController {
    
    func setUp() {
        view.addSubviews([sortButton, collectionView])
        collectionView.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: collectionView)
        
        NSLayoutConstraint.activate([
            sortButton.widthAnchor.constraint(equalToConstant: 42),
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -9),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    func didTapSortButton() {
        presenter.didTapSortButton()
    }
}

// MARK: - UICollectionViewDataSource

extension CatalogViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CatalogCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let cellModel = cellModels[indexPath.row]
        cell.configure(with: cellModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = collectionWidth - 32
        return CGSize(width: cellWidth, height: 179)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { 0 }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { 8 }
}

extension CatalogViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCollection(with: indexPath.row)
    }
}

// MARK: - CatalogView

extension CatalogViewController: CatalogView {
    
    func presentCollection(on viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func displayAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }

    func displayCells(_ cellModels: [CatalogCellModel]) {
        self.cellModels = cellModels
        collectionView.reloadData()
    }
}
