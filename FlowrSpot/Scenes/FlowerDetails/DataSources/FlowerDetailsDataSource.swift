//
//  FlowerDetailsDataSource.swift
//  FlowrSpot
//
//  Created by Marko Stajic on 01/05/2020.
//  Copyright © 2020 PovioLabs. All rights reserved.
//

import PovioKit

class FlowerDetailsDataSource: NSObject, DataSource {
  var sections = [FlowersSection]()
  private var flowers = [Flower]()
  
  func update(flowers: [Flower]) {
    self.flowers = flowers
    buildSections()
  }
}

// MARK: - UICollectionView DataSource
extension FlowerDetailsDataSource: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return numberOfSections()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfRows(in: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let row = row(at: indexPath) else {
      Logger.error("No availible row in dataSource at \(indexPath)")
      return UICollectionViewCell()
    }
    
    let cell = collectionView.dequeueReusableCell(FlowerCollectionViewCell.self, at: indexPath)
    switch row {
    case let .flower(entity):
      cell.setFlower(entity)
    }
    return cell
  }
}

// MARK: - Private Methods
private extension FlowerDetailsDataSource {
  func buildSections() {
    let rows = flowers.map(FlowersRow.flower)
    sections = [FlowersSection(rows: rows)]
  }
}
