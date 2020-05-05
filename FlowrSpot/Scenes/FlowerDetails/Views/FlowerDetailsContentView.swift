//
//  FlowerDetailsContentView.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit
import PovioKit

class FlowerDetailsContentView: UIView {
    let headerViewHeight: CGFloat = (UIScreen.main.bounds.width * 0.936)
    let headerView = FlowerDetailsHeaderView.autolayoutView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    let rightBarButton = UIButton(type: .custom)
    let emptyView = EmptyView.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlowerDetailsContentView {
    func showSearchButton() {
        guard rightBarButton.alpha == 0 else { return }
        
        let transform = CATransform3DRotate(CATransform3DIdentity, 0, 1, 0, 0)
        UIView.animate(withDuration: 0.3) {
            self.rightBarButton.layer.transform = transform
            self.rightBarButton.alpha = 1
        }
    }
    
    func hideSearchButton() {
        guard rightBarButton.alpha == 1 else { return }
        
        let transform = CATransform3DRotate(CATransform3DIdentity, .pi, 1, 0, 0)
        UIView.animate(withDuration: 0.3) {
            self.rightBarButton.alpha = 0
            self.rightBarButton.layer.transform = transform
        }
    }
}

private extension FlowerDetailsContentView {
    func setupViews() {
        backgroundColor = .white
        setupTableView()
        setupHeaderView()
        setupEmptyView()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
        tableView.register(SightingTableViewCell.self)
        tableView.register(FlowerDescriptionHeaderView.self)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupHeaderView() {
        addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(headerViewHeight)
        }
    }
    
    func setupEmptyView() {
        addSubview(emptyView)
        emptyView.text = "placeholder_no_content".localized()
        emptyView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
