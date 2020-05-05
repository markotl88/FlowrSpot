//
//  FlowerDetailsHeaderView.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 02/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import UIKit

class FlowerDetailsHeaderView: UIView {
    
    private let backgroundImageView = UIImageView.autolayoutView()
    private let titleLabel = UILabel.autolayoutView()
    private let subtitleLabel = UILabel.autolayoutView()
    private let sightingImageView = UIImageView.autolayoutView()
    private let sightingLabelContainerView = UIView.autolayoutView()
    private let sightingLabel = UILabel.autolayoutView()
    private let sightingButton = UIButton.autolayoutView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateFlower(_ flower: Flower) {
        backgroundImageView.kf.indicatorType = .activity
        backgroundImageView.kf.setImage(with: URL(string: "http:\(flower.profilePicture)"))
        titleLabel.text = flower.name
        subtitleLabel.text = flower.latinName
        sightingLabel.text = "sightings_count".localized(flower.sightings ?? 0)
        backgroundImageView.addBlackGradientLayerInBackground(frame: backgroundImageView.bounds, colors: [.clear, .black])
    }
    
    public func deinitViews() {
        backgroundImageView.image = nil
    }
}

// MARK: - Private methods
private extension FlowerDetailsHeaderView {
    func setupViews() {
        clipsToBounds = false
        setupBackgroundImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupSightingImageView()
        setupSightingLabel()
        setupSightingButton()
    }
    
    func setupBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .custom(type: .regular, size: 35)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(UIScreen.main.bounds.width * 0.46)
            $0.left.equalTo(23)
            $0.right.equalTo(-23)
        }
    }
    
    func setupSightingImageView() {
        addSubview(sightingImageView)
        
        sightingImageView.backgroundColor = .white
        sightingImageView.image = UIImage(named: "plIconStar")
        sightingImageView.contentMode = .center
        sightingImageView.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top).offset(-15)
            $0.width.height.equalTo(30)
            $0.leading.equalTo(23)
        }
        sightingImageView.layer.cornerRadius = 15
    }
    
      func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.font = .custom(type: .regular, size: 14)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.alpha = 0.7
        subtitleLabel.textColor = .white
        subtitleLabel.snp.makeConstraints {
          $0.left.equalTo(23)
          $0.right.equalTo(-23)
          $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
      }
    
    func setupSightingLabel() {
        
        addSubview(sightingLabelContainerView)
        sightingLabelContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        sightingLabelContainerView.snp.makeConstraints {
            $0.left.equalTo(sightingImageView.snp.right).offset(10)
            $0.centerY.equalTo(sightingImageView.snp.centerY)
            $0.height.equalTo(30)
        }
        sightingLabelContainerView.layer.cornerRadius = 15
        
        sightingLabelContainerView.addSubview(sightingLabel)
        
        sightingLabel.font = .custom(type: .regular, size: 12)
        sightingLabel.textAlignment = .center
        sightingLabel.numberOfLines = 1
        sightingLabel.textColor = .white
        sightingLabel.snp.makeConstraints {
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupSightingButton() {
        addSubview(sightingButton)
        sightingButton.backgroundColor = UIColor.flowrDarkRed
        sightingButton.setTitle("add_sighting".localized(), for: .normal)
        sightingButton.setTitleColor(UIColor.white, for: .normal)
        sightingButton.titleLabel?.font = .custom(type: .regular, size: 14)
        sightingButton.snp.makeConstraints {
            $0.left.equalTo(23)
            $0.height.equalTo(48)
            $0.width.equalTo(188)
            $0.centerY.equalTo(self.snp.bottom)
        }
    }
}
