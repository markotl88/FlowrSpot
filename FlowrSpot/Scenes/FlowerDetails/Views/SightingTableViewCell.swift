//
//  SightingTableViewCell.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 05/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit
import Kingfisher

class SightingTableViewCell: UITableViewCell {
    private let flowerImageView = UIImageView.autolayoutView()
    private let userImageView = UIImageView.autolayoutView()
    private let titleLabel = UILabel.autolayoutView()
    private let userLabel = UILabel.autolayoutView()
    private let descriptionLabel = UILabel.autolayoutView()
    private let separatorView = UIView.autolayoutView()
    private let commentsImageView = UIImageView.autolayoutView()
    private let commentsLabel = UILabel.autolayoutView()
    private let likesImageView = UIImageView.autolayoutView()
    private let likesLabel = UILabel.autolayoutView()
    private let locationImageView = UIImageView.autolayoutView()
    private let locationView = UIView.autolayoutView()
    private let locationLabel = UILabel.autolayoutView()
    private let gradientLayer = CAGradientLayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
}

// MARK: - Public methods
extension SightingTableViewCell {
    func setSighting(_ sighting: Sighting) {
        titleLabel.text = sighting.name
        flowerImageView.kf.setImage(with: URL(string: "http:\(sighting.picture)"))
        if let user = sighting.user?.fullName {
            userLabel.text = "by_user".localized(user.capitalized)
        } else {
            userLabel.text = "by_unknown_user".localized()
        }
        if let profileImage = sighting.user?.profilePicture {
            userImageView.kf.setImage(with: URL(string: "http:\(profileImage)"))
        }
        descriptionLabel.text = sighting.description
        commentsLabel.text = "comments_count".localized(sighting.commentsCount ?? 0)
        likesLabel.text = "likes_count".localized(sighting.likesCount ?? 0)
        ReverseGeocoder.getCity(latitude: sighting.latitude, longitude: sighting.longitude) { [weak self] (cities) in
            DispatchQueue.main.async {
                self?.locationLabel.text = cities.first
            }
        }
    }
}

// MARK: - Private methods
private extension SightingTableViewCell {
    func setupViews() {
        self.selectionStyle = .none
        layer.masksToBounds = true
        layer.cornerRadius = 3
        setupImageView()
        setupLocationView()
        setupLocationImageView()
        setupLocationLabel()
        setupUserImageView()
        setupTitleLabel()
        setupUserLabel()
        setupDescriptionLabel()
        setupSeparatorView()
        setupCommentsImageView()
        setupCommentsLabel()
        setupLikesImageView()
        setupLikesLabel()
    }
    
    func setupImageView() {
        addSubview(flowerImageView)
        flowerImageView.clipsToBounds = true
        flowerImageView.kf.indicatorType = .activity
        flowerImageView.contentMode = .scaleAspectFill
        flowerImageView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.size.width * 0.65)
            $0.top.leading.trailing.equalToSuperview()
        }
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 0.65)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.opacity = 0.8
        flowerImageView.layer.addSublayer(gradientLayer)

    }
        
    func setupLocationView() {
        addSubview(locationView)
        locationView.backgroundColor = UIColor.white
        locationView.snp.makeConstraints {
            $0.top.equalTo(flowerImageView.snp.top).offset(20)
            $0.leading.equalTo(flowerImageView.snp.leading).offset(20)
            $0.height.equalTo(26)
            $0.width.greaterThanOrEqualTo(100)
        }
        locationView.layer.cornerRadius = 13
    }
    
    func setupLocationImageView() {
        locationView.addSubview(locationImageView)
        locationImageView.contentMode = .scaleAspectFit
        locationImageView.image = AssetCatalog.plIconLocation.image
        locationImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
    }
    
    func setupLocationLabel() {
        locationView.addSubview(locationLabel)
        locationLabel.font = .custom(type: .regular, size: 12)
        locationLabel.textColor = UIColor.flowrLightRed
        locationLabel.textAlignment = .left
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupUserImageView() {
        addSubview(userImageView)
        userImageView.kf.indicatorType = .activity
        userImageView.image = AssetCatalog.plIconUser.image.withRenderingMode(.alwaysTemplate)
        userImageView.tintColor = .flowrGray
        userImageView.contentMode = .scaleAspectFill
        userImageView.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.top.equalTo(flowerImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }

    }
 
    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .custom(type: .regular, size: 15)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(-26)
            $0.top.equalTo(userImageView.snp.top).offset(12)
        }
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
    }
    
    func setupUserLabel() {
        addSubview(userLabel)
        userLabel.font = .custom(type: .italic, size: 12)
        userLabel.textColor = UIColor.flowrGray
        userLabel.textAlignment = .left
        userLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(-26)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        userLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        userLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font = .custom(type: .regular, size: 13)
        descriptionLabel.textColor = UIColor.flowrGray
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 2
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(26)
            $0.trailing.equalTo(-26)
            $0.top.equalTo(userLabel.snp.bottom).offset(24)
        }
    }
    
    func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.backgroundColor = UIColor.flowrLightGray
        separatorView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalTo(26)
            $0.trailing.equalTo(-26)
            $0.height.equalTo(1)
        }
    }
    
    func setupCommentsImageView() {
        addSubview(commentsImageView)
        commentsImageView.image = AssetCatalog.plIconComment.image
        commentsImageView.contentMode = .scaleAspectFit
        commentsImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.leading.equalTo(20)
            $0.top.equalTo(separatorView.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupCommentsLabel() {
        addSubview(commentsLabel)
        commentsLabel.font = .custom(type: .regular, size: 12)
        commentsLabel.textColor = UIColor.flowrGray
        commentsLabel.textAlignment = .left
        commentsLabel.numberOfLines = 1
        commentsLabel.snp.makeConstraints {
            $0.leading.equalTo(commentsImageView.snp.trailing).offset(25)
            $0.centerY.equalTo(commentsImageView.snp.centerY)
        }
    }
    
    func setupLikesImageView() {
        addSubview(likesImageView)
        likesImageView.image = AssetCatalog.plIconLike.image
        likesImageView.contentMode = .scaleAspectFit
        likesImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.leading.equalTo(self.snp.centerX).offset(20)
            $0.centerY.equalTo(commentsImageView.snp.centerY)
        }

    }

    func setupLikesLabel() {
        addSubview(likesLabel)
        likesLabel.font = .custom(type: .regular, size: 12)
        likesLabel.textColor = UIColor.flowrGray
        likesLabel.textAlignment = .left
        likesLabel.numberOfLines = 1
        likesLabel.snp.makeConstraints {
            $0.leading.equalTo(likesImageView.snp.trailing).offset(25)
            $0.centerY.equalTo(commentsImageView.snp.centerY)
        }
    }
}
