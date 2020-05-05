//
//  FlowerDetailsViewController.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit

fileprivate struct UIConstants {
    static let rowEstimatedHeight: CGFloat = 300
    static let headerEstimatedHeight: CGFloat = 300
    static let footerEstimatedHeight: CGFloat = 0.1
}

protocol FlowerDetailsDisplayLogic: class {
    func displayFlower(_ flower: Flower)
    func displaySightings(_ sightings: [Sighting])
    func displayError(_ error: RemoteResourceError)
}

class FlowerDetailsViewController: UIViewController {
    var interactor: FlowerDetailsBusinessLogic?
    var router: FlowerDetailsRoutingLogic?
    private lazy var contentView = FlowerDetailsContentView.autolayoutView()
    private let flowerDetailsDataSource = FlowerDetailsDataSource()
    private let flowerDescriptionDataSource = FlowerDescriptionDataSource()
    
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
        setupContentView()
        setupNavigationView()
        loadData()
    }
}

// MARK: - Display Logic
extension FlowerDetailsViewController: FlowerDetailsDisplayLogic {
    func displaySightings(_ sightings: [Sighting]) {
        flowerDetailsDataSource.update(sightings: sightings)
        contentView.tableView.reloadData()
        contentView.emptyView.isHidden = true
    }
    
    func displayFlower(_ flower: Flower) {
        contentView.headerView.updateFlower(flower)
        flowerDescriptionDataSource.update(flower: flower)
    }
    
    func displayError(_ error: RemoteResourceError) {
        router?.navigateToAlert(title: "general_error".localized(), message: error.localizedDescription, handler: nil)
        contentView.emptyView.isHidden = false
    }
}

// MARK: - UICollectionView Delegate
extension FlowerDetailsViewController: UITableViewDelegate {
    
    // MARK: - TableView cell setup
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = flowerDetailsDataSource.row(at: indexPath) else {
            Logger.error("No availible row in dataSource at \(indexPath)")
            return
        }
        switch row {
        case let .sighting(entity):
            router?.navigateToSightingDetails(sighting: entity)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.rowEstimatedHeight
    }
        
    // MARK: - HeaderView setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(FlowerDescriptionHeaderView.self)
        cell.setDataSource(flowerDescriptionDataSource)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.headerEstimatedHeight
    }
    
    // MARK: - FooterView setup
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UIConstants.footerEstimatedHeight
    }
}

//// MARK: - UIScrollView Delegate
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: AssetCatalog.plIconBack.image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backBarButtonPressed))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.flowrGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: AssetCatalog.plIconDots.image.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(barButtonPressed))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.flowrGray
    }
    
    func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.rightBarButton.setImage(AssetCatalog.plIconSearch.image, for: .normal)
        contentView.rightBarButton.addTarget(self, action: #selector(barButtonPressed), for: .touchUpInside)
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = flowerDetailsDataSource
        contentView.headerView.addNewSighting = { [weak self] (flower) in
            self?.router?.navigateToNewSighting(flower: flower)
        }
    }
    
    func setupNavigationView() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func loadData() {
        interactor?.fetchFlower()
        interactor?.fetchFlowerSightings()
    }
    
    @objc func backBarButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func barButtonPressed() {
        contentView.tableView.setContentOffset(CGPoint(x: 0, y: -contentView.headerViewHeight), animated: true)
    }
}

extension FlowerDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
