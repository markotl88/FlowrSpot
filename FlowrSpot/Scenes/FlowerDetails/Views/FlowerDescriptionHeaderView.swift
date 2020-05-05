//
//  FlowerDescriptionHeaderView.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

class FlowerDescriptionHeaderView: UITableViewHeaderFooterView {
    
    private let featuresLabel = UILabel.autolayoutView()
    private let descriptionLabel = UILabel.autolayoutView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlowerDescriptionHeaderView {
    func setDataSource(_ dataSource: FlowerDescriptionDataSource) {
        descriptionLabel.text = dataSource.getDescription()
        if let features = dataSource.getFeatures() {
            setFeatures(features.joined(separator: "\n"))
        }
    }
}

// MARK: - Private methods
private extension FlowerDescriptionHeaderView {
    func setupViews() {
        setupFeaturesLabel()
        setupDescriptionLabel()
    }
    
    func setupFeaturesLabel() {
        addSubview(featuresLabel)
        featuresLabel.numberOfLines = 0
        featuresLabel.textAlignment = .justified
        featuresLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.leading.equalTo(23)
            $0.trailing.equalTo(-23)
        }
    }
    
    func setFeatures(_ features: String) {
        let attributedString = NSMutableAttributedString(string: features)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        paragraphStyle.alignment = .justified
        
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.custom(type: .bold, size: 13), NSAttributedString.Key.foregroundColor: UIColor.flowrGray]
        let attrStringRange = NSRange(location: 0, length: features.count)
        
        attributedString.addAttributes(attributes, range: attrStringRange)
        featuresLabel.attributedText = attributedString
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font = .custom(type: .regular, size: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = UIColor.flowrGray
        descriptionLabel.textAlignment = .justified
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(featuresLabel.snp.bottom).offset(30)
            $0.leading.equalTo(23)
            $0.trailing.equalTo(-23)
            $0.bottom.equalTo(-32)
        }
    }
}
