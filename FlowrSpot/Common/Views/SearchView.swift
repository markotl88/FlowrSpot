//
//  SearchView.swift
//  FlowrSpot
//
//  Created by TK on 16/01/2018.
//  Copyright © 2018 PovioLabs. All rights reserved.
//

import UIKit

class SearchView: UIView {
  private let placeholderLabel = UILabel.autolayoutView()
  private let iconImageView = UIImageView.autolayoutView()
  private let textField = UITextField.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    becomeFirstResponder()
  }
}

// MARK: - Public methods
extension SearchView {
  @discardableResult
  override func becomeFirstResponder() -> Bool {
    textField.becomeFirstResponder()
    return super.becomeFirstResponder()
  }
  
  var placeholder: String? {
    get { return placeholderLabel.text }
    set { placeholderLabel.text = newValue }
  }
  
  var text: String? {
    get { return textField.text }
    set { textField.text = newValue }
  }
  
  var font: UIFont? {
    get { return textField.font }
    set {
      textField.font = newValue
      placeholderLabel.font = newValue
    }
  }
  
  var placeholderColor: UIColor {
    get { return placeholderLabel.textColor }
    set { placeholderLabel.textColor = newValue }
  }
  
  var textColor: UIColor? {
    get { return textField.textColor }
    set { textField.textColor = newValue }
  }
}

// MARK: - UITextField Delegate
extension SearchView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let query = replacingString(for: textField.text ?? "", replacementString: string, range: range)
    togglePlaceholder(text: query)
    return true
  }
}

// MARK: - Private methods
private extension SearchView {
  func replacingString(for currentText: String, replacementString string: String, range: NSRange) -> String {
    return NSString(string: currentText).replacingCharacters(in: range, with: string) as String
  }
  
  func togglePlaceholder(text: String) {
    UIView.animate(withDuration: 0.3) {
      self.placeholderLabel.isHidden = !text.isEmpty
    }
  }
}

// MARK: - Private methods
private extension SearchView {
  func setupViews() {
    backgroundColor = .white
    layer.cornerRadius = 2
    setupIconImageView()
    setupPlaceholderLabel()
    setupTextField()
  }
  
  func setupIconImageView() {
    addSubview(iconImageView)
    iconImageView.image = AssetCatalog.plIconSearch.image
    iconImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.right.equalTo(-20)
      $0.size.equalTo(14)
    }
  }
  
  func setupPlaceholderLabel() {
    addSubview(placeholderLabel)
    placeholderLabel.font = UIFont.custom(type: .light, size: 14)
    placeholderLabel.textColor = .flowrGray
    placeholderLabel.snp.makeConstraints {
      $0.left.equalTo(20)
      $0.right.equalTo(iconImageView.snp.left).inset(20)
      $0.centerY.equalToSuperview()
    }
  }
  
  func setupTextField() {
    addSubview(textField)
    textField.font = UIFont.custom(type: .light, size: 14)
    textField.textColor = .black
    textField.delegate = self
    textField.snp.makeConstraints {
      $0.left.equalTo(20)
      $0.right.equalTo(iconImageView.snp.left).offset(-10)
      $0.centerY.equalToSuperview()
    }
  }
}
