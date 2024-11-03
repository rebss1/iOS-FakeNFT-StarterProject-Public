//
//  NftCollectionViewController.swift
//  FakeNFT
//
//  Created by Илья Лощилов on 22.10.2024.
//

import UIKit

protocol NftCollectionView: AnyObject, ErrorView, LoadingView {
    func displayHeader(_ headerModel: NftCollectionHeaderModel)
    func displayCells(_ cellModels: [NftCollectionCellModel])
    func displayAlert(_ alert: UIAlertController)
    func displayAuthorDetails(_ detailsViewController: AuthorDetailsViewController)
}

final class NftCollectionViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Private Properties
    
    private lazy var collectionWidth = collectionView.frame.width
    
    private let presenter: NftCollectionPresenter
    private var cellModels: [NftCollectionCellModel] = []
    private var headerModel: NftCollectionHeaderModel?
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NftCollectionHeader.self)
        collectionView.register(NftCollectionCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backward"), for: .normal)
        button.tintColor = .blackCustom
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(didTapBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    
    init(presenter: NftCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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

private extension NftCollectionViewController {

    func setUp() {
        collectionView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .whiteCustom
        view.addSubviews([collectionView, backButton])
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: collectionView)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 9),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    func didTapBackButton() {
        dismiss(animated: true)
    }
}

    // MARK: - UICollectionViewDataSource

extension NftCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cellModels.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: NftCollectionHeader = collectionView.dequeueReusableCell(indexPath: indexPath)
            if let headerModel = self.headerModel {
                cell.configure(with: headerModel)
            }
            cell.delegate = self
            return cell
        case 1:
            let cell: NftCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            let cellModel = cellModels[indexPath.row]
            cell.configure(with: cellModel)
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension NftCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: collectionWidth,
                          height: 446)
        case 1:
            return CGSize(width: (collectionWidth - 50) / 3,
                          height: 192)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        switch section {
        case 0 :
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        default:
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { 9 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { 8 }
}

    // MARK: - NftCollectionView

extension NftCollectionViewController: NftCollectionView {
    
    func displayHeader(_ headerModel: NftCollectionHeaderModel) {
        self.headerModel = headerModel
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func displayCells(_ cellModels: [NftCollectionCellModel]) {
        self.cellModels = cellModels
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func displayAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func displayAuthorDetails(_ detailsViewController: AuthorDetailsViewController) {
        present(detailsViewController, animated: true)
    }
}

    // MARK: - NftCollectionCellDelegate

extension NftCollectionViewController: NftCollectionCellDelegate {
    
    func didTapLikeButton(in cell: NftCollectionCell) {
        guard
            let indexPath = collectionView.indexPath(for: cell)
        else { return }
        presenter.didTapLikeButton(on: indexPath)
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func didTapCartButton(in cell: NftCollectionCell) {
        guard
            let indexPath = collectionView.indexPath(for: cell)
        else { return }
        presenter.didTapCartButton(on: indexPath)
        collectionView.reloadSections(IndexSet(integer: 1))
    }
}

extension NftCollectionViewController: NftCollectionHeaderDelegate {
    
    func didTapAuthorButton(in cell: NftCollectionHeader) {
        guard
            let indexPath = collectionView.indexPath(for: cell)
        else { return }
        presenter.didTapAuthorButton(on: indexPath)
    }
}
