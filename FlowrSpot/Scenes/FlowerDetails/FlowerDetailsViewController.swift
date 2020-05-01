//
//  FlowerDetailsViewController.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit

protocol FlowerDetailsDisplayLogic: class {
    func displayFlower(_ flower: Flower)
    func displayError(_ error: RemoteResourceError)
}

class FlowerDetailsViewController: UIViewController {
    var interactor: FlowerDetailsBusinessLogic?
    var router: FlowerDetailsRoutingLogic?
    private lazy var contentView = FlowerDetailsContentView.autolayoutView()
    private let flowersDataSource = FlowersDataSource()
    
    init(delegate: FlowerDetailsRouterDelegate?, flowerId: Int) {
        super.init(nibName: nil, bundle: nil)
        let interactor = FlowerDetailsInteractor()
        interactor.flowerId = flowerId
        let presenter = FlowerDetailsPresenter()
        let router = FlowerDetailsRouter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.delegate = delegate
        self.interactor = interactor
        self.router = router
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
}

// MARK: - Display Logic
extension FlowerDetailsViewController: FlowerDetailsDisplayLogic {
    
    func displayFlower(_ flower: Flower) {
        contentView.headerView.updateFlower(flower)
//                flowersDataSource.update(flowers: flowers)
//                contentView.collectionView.reloadData()
//                contentView.emptyView.isHidden = true
    }
    
    func displayError(_ error: RemoteResourceError) {
        router?.navigateToAlert(title: "general_error".localized(), message: error.localizedDescription, handler: nil)
        contentView.emptyView.isHidden = false
    }
}

// MARK: - UICollectionView Delegate
extension FlowerDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return contentView.collectionViewDimensions.sizeForItem(at: indexPath, for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = flowersDataSource.row(at: indexPath) else {
            Logger.error("No availible row in dataSource at \(indexPath)")
            return
        }
        switch row {
        case let .flower(entity):
            debugPrint("Entity: \(entity)")
            //      router?.navigateToFlowerDetails(flower: entity)
        }
    }
}

// MARK: - UIScrollView Delegate
extension FlowerDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = -scrollView.contentOffset.y
        
        let percentage = 1 - (contentOffset / contentView.headerViewHeight)
        
        var headerViewTranslation = -percentage * contentView.headerViewHeight
        if headerViewTranslation > 0 {
            headerViewTranslation = 0 // lock headerView
        }
        
        contentView.headerView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: headerViewTranslation)
        
        switch percentage {
        case 0.75...:
            contentView.showSearchButton()
        case _:
            contentView.hideSearchButton()
        }
    }
}

// MARK: - Private methods
private extension FlowerDetailsViewController {
    func setupViews() {
        navigationItem.title = "general_app_name".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "plIconBack")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backBarButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flowrGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plIconDots")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(barButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flowrGray
        setupContentView()
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.rightBarButton.setImage(#imageLiteral(resourceName: "plIconSearch"), for: .normal)
        contentView.rightBarButton.addTarget(self, action: #selector(barButtonPressed), for: .touchUpInside)
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = flowersDataSource
    }
    
    func setupNavigationView() {
    }
    
    func loadData() {
        interactor?.fetchFlower()
    }
    
    @objc func backBarButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func barButtonPressed() {
        contentView.collectionView.setContentOffset(CGPoint(x: 0, y: -contentView.headerViewHeight), animated: true)
    }
}
